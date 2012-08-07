#!/usr/bin/env python
# coding: utf-8

from config import settings
import web
from forms import *
from datetime import datetime
import hashlib



db = settings.db
render = settings.render_admin

d = dict()

# login
def login_required(func):
    def Function(*args):
        if web.ctx.session.isAdmin == 0:
            raise web.seeother('/login/')
        else:
            return func(*args)
    return Function

class login(object):
    def GET(self):
        f = loginForm()
        d['f'] = f
        return render.login(**d)

    def POST(self):
        f = loginForm()
        i = web.input()
        if f.validates():
            passwd = hashlib.md5(i.get('passwd')).hexdigest()
            admin = list(db.select('user', what='passwd', where='username="%s"' \
                                   % i.get('username')))
            if len(admin) > 0:
                if passwd == admin[0].passwd:
                    web.ctx.session.isAdmin = 1
                    raise web.seeother('/')

            errs = 'username/passwd error.'
            d['errs'] = errs
            return render.login(**d)
        else:
            d['f'] = f
            return render.login(**d)

class logout(object):
    def GET(self):
        web.ctx.session.kill()
        raise web.seeother('/')

# admin operation
class index(object):
    @login_required
    def GET(self):
        #print web.ctx.session.isAdmin
        entryNum = list(db.query("SELECT COUNT(id) as num from entries"))
        catNum = list(db.query("SELECT COUNT(id) as num from categories"))
        tagNum = list(db.query("SELECT COUNT(id) as num from tags"))
        commentNum = list(db.query("SELECT COUNT(id) as num from comments"))
        linkNum = list(db.query("SELECT COUNT(id) as num from links"))

        d['entryNum'] = entryNum[0].num
        d['categoryNum'] = catNum[0].num
        d['tagNum'] = tagNum[0].num
        d['commentNum'] = commentNum[0].num
        d['linkNum'] = linkNum[0].num
        return render.index(**d)

class entries(object):
    @login_required
    def GET(self):
        entries = list(db.query("SELECT title AS entry_title, created_time, \
                                id, modified_time FROM entries ORDER BY id DESC"))
        d['entries'] = entries
        return render.entries(**d)

class entryAdd(object):
    @login_required
    def GET(self):
        # specify the selected columns when query the db.
        what = 'id, name, entry_num'
        cats = list(db.select('categories', what=what))
        d['categories'] = cats
        return render.entryAdd(**d)

    @login_required
    def POST(self):
        f = entryForm()
        i = web.input(tags=None)
        catId = i['category_id']
        if f.validates():
            entryId = db.insert('entries', title=i['title'], slug=i['slug'], category_id=catId, \
                                modified_time=datetime.now(), created_time=datetime.now(), content=i['content'])
            # print i['tags'] == None, type(i['tags']), len(i['tags'])
            if entryId:
                db.query("update categories set entry_num = entry_num +1 where id=%d" % int(catId))

            # i['tags'] == [''] != None, so use len(i['tags']) instead.
            if len(i['tags']) > 0:
                tags = [i.strip() for i in i['tags'].split(',')]
                for t in tags:
                    tmpTag = db.select('tags', what='id', where='name="%s"' % t).list()
                    if len(tmpTag) > 0:
                        db.insert('entry_tag', entry_id=entryId, tag_id=tmpTag[0].id)
                        db.query("UPDATE tags SET entry_num = entry_num + 1 WHERE id=%d" % tmpTag[0].id)
                    else:
                        t_id = db.insert('tags', name=t, entry_num=1)
                        db.insert('entry_tag', entry_id=entryId, tag_id=t_id)
            return web.seeother('/entries/')

        else:
            return web.seeother('/entry/add/')


class entryEdit(object):

    @login_required
    def get_entry(self, id):
        """
        get the entry with tags included. if entry not empty return it else return None.
        """
        entry = list(db.select('entries', where="id=$id", vars={'id': id}))
        if len(entry) > 0:
            entry = entry[0]
            tags = list(db.query("SELECT t.name AS name FROM tags t LEFT JOIN \
                                 entry_tag et ON t.id = et.tag_id WHERE et.entry_id \
                                 = $id", vars={'id': id}))
            entry.tags = ",".join(t.name for t in tags)
            return entry
        else:
            return None

    @login_required
    def GET(self, id):
        entry = self.get_entry(id)

        if entry is not None:
            f = entryForm()
            f.title.value = entry.title
            f.slug.value = entry.slug
            #f.category_id.value = entry.category_id
            #f.content.value = entry.content
            categories = list(db.select('categories', what='id, name, entry_num'))
            tags = list(db.query("SELECT t.name AS name FROM tags t LEFT JOIN \
                                 entry_tag et ON t.id = et.tag_id WHERE et.entry_id \
                                 = $id", vars={'id': id}))
            entry.tags = ",".join(t.name for t in tags)
            d['entry'] = entry
            d['categories'] = categories
            d['f'] = f

        return render.entryEdit(**d)

    @login_required
    def POST(self, id):
        entry = self.get_entry(id)
        f = entryForm()
        # set default value for some col in entries table
        i = web.input(title=None, slug=None, category_id=None, tags=None)
        if f.validates():
            if i.tags is not None:
                newTags = set([t.strip() for t in i.tags.split(',')])
                origTags = set([t.strip() for t in entry.tags.split(',')])
                # use filter to remove the empty string
                tagsAdd = filter(len, list(newTags - origTags))
                tagsDel = filter(len, list(origTags- newTags))
                #tagsAdd = filter(lambda x: len(x) > 0, list(newTags - origTags))
                #tagsDel = filter(lambda x: len(x) > 0, list(origTags - newTags))
                #tagsAdd = list(origTags - newTags).remove('')
                #tagsDel = list(origTags - newTags).remove('')
                #print tagsAdd, tagsDel

                if tagsAdd:
                    # add some tags in new entry
                    for t in tagsAdd:
                        t_id = ''
                        tagExists = list(db.select('tags', what='id, entry_num', \
                                                   where='name=$n', vars={'n': t}))
                        if tagExists:
                            db.update('tags', where='name=$n', entry_num = \
                                      tagExists[0].entry_num + 1, vars = {'n': t})
                            #db.query("UPDATE tags SET entry_num = entry_num + 1 WHERE name='%s'" % t)
                            t_id = tagExists[0].id
                        else:
                            t_id = db.insert('tags', name=t, entry_num = 1)
                        #print t_id
                        db.insert('entry_tag', entry_id=id, tag_id = t_id)

                if tagsDel:
                    # delete some original tags in entry
                    for t in tagsDel:
                        t_id = list(db.select('tags', what='id, entry_num', where='name=$name', \
                                              vars={'name': t}))
                        db.delete('entry_tag', where='tag_id=$id',vars={'id': t_id[0].id})
                        if t_id[0].entry_num == 0:
                            db.delete('tags', where='name=$n', vars={'n': t})
                            #print 'tag deleted:', t_id, t

            #print entry.category_id, i.category_id
            if i.category_id != entry.category_id and int(entry.category_id) > 0:
                oldCat = list(db.select('categories', what='entry_num', where='id=$id', \
                                        vars={'id': entry.category_id}))
                if oldCat[0].entry_num > 0:
                    db.update('categories', where='id=%s' % entry.category_id, \
                              entry_num = int(oldCat[0].entry_num) - 1)
                    # new category
                newCat = list(db.select('categories', what='id, entry_num', where='id=$id', \
                                            vars={'id': i.category_id}))
                db.update('categories', where='id=%s' % newCat[0].id, entry_num=int(newCat[0].entry_num)+1)
                print i.slug
                db.update('entries', where='id=%s' % id, category_id=newCat[0].id, \
                       title=i.title, slug=i.slug, content=i.content)
            else:
                db.update('entries', where='id=%s' % id, title=i.title, slug=i.slug, content=i.content)
            return web.seeother('/entries/')
        else:
            d['f'] = f
            d['entry'] = entry
            return render.entryEdit(**d)


class entryDel(object):
    @login_required
    def GET(self, id):
        # delete the comment reference
        db.query("DELETE FROM comments WHERE entry_id=$id", vars={'id': id})
        # update the categories table
        catId = list(db.select('entries', what='category_id', where='id=%d' % int(id)))
        if catId:
            db.query("UPDATE categories SET entry_num = entry_num - 1 WHERE id=%d" % int(catId[0].category_id))
        # set the tags table entry_num - 1
        tags = list(db.select('entry_tag', what='tag_id', where='entry_id=%d' % int(id)))
        if tags:
            for one in tags:
                db.query("UPDATE tags SET entry_num = entry_num - 1 WHERE id=%d" % one.tag_id)
                # delete the entry_tag table
                db.query("DELETE FROM entry_tag WHERE entry_id=$id", vars={'id': id})
                #for t in et:
                #    db.query("DELETE FROM tags WHERE id=$tag_id", vars={'tag_id': t.tag_id})
        db.query("DELETE FROM entries WHERE id=$id", vars={'id': id})
        return web.seeother('/entries/')

class comments(object):
    @login_required
    def GET(self):
        #c = list(db.select('comments'))
        comments = list(db.select('comments', what='id, username, email, comment, created_time'))
        d['comments'] = comments
        return render.comments(**d)

class commentEdit(object):
    @login_required
    def GET(self, id):
        cmt = list(db.select('comments', where='id=$id', vars={'id': id}))[0]
        f = commentForm()
        f.username.value = cmt['username']
        f.email.value = cmt['email']
        f.comment.value = cmt['comment']
        f.createdTime.value = cmt['created_time']
        d['f'] = f
        # get the cmt id for post.
        d['cmtId'] = cmt['id']
        return render.commentEdit(**d)

    @login_required
    def POST(self, id):
        f = commentForm()
        if f.validates():
            db.update('comments', where='id=$id', comment=f.comment.value, vars={'id': id})
            return web.seeother('/comments/')
        else:
            d['f'] = f
            d['cmtId'] = id
            return render.commentEdit(**d)

class commentDel(object):
    @login_required
    def GET(self, id):
        db.delete('comments', where='id=$id', vars={'id': id})
        return web.seeother('/comments/')

class tags(object):
    @login_required
    def GET(self):
        tags = list(db.select('tags'))
        d['tags'] = tags
        return render.tags(**d)

class tagAdd(object):
    @login_required
    def GET(self):
        f = tagForm()
        d['f'] = f
        return render.tagAdd(**d)

    @login_required
    def POST(self):
        f = tagForm()
        i = web.input()
        if f.validates():
            db.insert('tags', name=i['name'], entry_num=i['entry_num'])
            return web.seeother('/tags/')
        else:
            d['f'] = f
            return render.tagAdd(**d)

class tagEdit(object):
    @login_required
    def GET(self, id):
        f = tagForm()
        tag = list(db.select('tags', where='id=$id', vars={'id': id}))[0]
        f.name.value = tag['name']
        f.entry_num.value = tag['entry_num']
        d['f'] = f
        d['tId'] = tag['id']
        return render.tagEdit(**d)

    @login_required
    def POST(self, id):
        f = tagForm()
        if f.validates():
            db.update('tags', where='id=$id', name=f.name.value, entry_num=f.entry_num.value, \
                      vars={'id': id})
            return web.seeother('/tags/')
        else:
            d['f'] = f
            d['tId'] = id
            return render.tagEdit(**d)

class tagDel(object):
    @login_required
    def GET(self, id):
        print id
        db.delete('entry_tag', where='tag_id=$id', vars={'id': id})
        db.delete('tags', where='id=$id', vars={'id': id})
        return web.seeother('/tags/')

class categories(object):
    @login_required
    def GET(self):
        cats = list(db.select('categories'))
        d['cats'] = cats
        return render.categories(**d)

class categoryAdd(object):
    @login_required
    def GET(self):
        f = catForm()
        d['f'] = f
        return render.categoryAdd(**d)

    @login_required
    def POST(self):
        f = catForm()
        i = web.input(slug=None)
        if f.validates():
            db.insert('categories', name=i['name'], slug=i['slug'], entry_num=i['entry_num'],\
                      createdTime=datetime.now(), modifiedTime=datetime.now())
            return web.seeother('/categories/')
        else:
            d['f'] = f
            return render.categoryAdd(**d)

class categoryEdit(object):
    @login_required
    def GET(self, id):
        f = catForm()
        cat = list(db.select('categories', where='id=$id', vars={'id': id}))[0]
        f.name.value = cat['name']
        f.slug.value = cat['slug']
        f.entry_num.value = cat['entry_num']
        d['f'] = f
        d['catId'] = cat['id']
        return render.categoryEdit(**d)

    @login_required
    def POST(self, id):
        f = catForm()
        if f.validates():
            db.update('categories', where='id=$id', name=f.name.value, slug=f.slug.value,\
                      entry_num=f.entry_num.value, modifiedTime=datetime.now(), vars={'id': id})
            return web.seeother('/categories/')
        else:
            d['f'] = f
            d['catId'] = id
            return render.categoryEdit(**d)

class categoryDel(object):
    @login_required
    def GET(self, id):
        entry = db.select('entries', what='slug', where='id=$id', vars={'id': id}).list()
        # if category not empty, do not delete the category.
        # todo: add 'undefine' category, when delete a category, move those entries
        #       under this category to 'undefine' category.
        if not len(entry) > 0:
            return web.seeother('/categories/')
        else:
            db.delete('categories', where='id=$id', vars={'id': id})
            return web.seeother('/categories/')


class links(object):
    @login_required
    def GET(self):
        links = list(db.select('links'))
        d['links'] = links
        return render.links(**d)

class linkAdd(object):
    @login_required
    def GET(self):
        f = linkForm()
        d['f'] = f
        return render.linkAdd(**d)

    @login_required
    def POST(self):
        f = linkForm()
        i = web.input()
        if f.validates():
            db.insert('links', name=i['name'], url=i['url'], description=i['desc'], \
                      created_time=datetime.now())
            return web.seeother('/links/')
        else:
            d['f'] = f
            return render.linkAdd(**d)

class linkEdit(object):
    @login_required
    def GET(self, id):
        f = linkForm()
        lk = list(db.select('links', where='id=$id', vars=dict(id=id)))[0]
        f.name.value = lk.name
        f.url.value = lk.url
        f.desc.value = lk.description
        d['f'] = f
        d['linkId'] = lk.id
        return render.linkEdit(**d)

    @login_required
    def POST(self, id):
        f = linkForm()
        if f.validates():
            db.update('links', where='id=$id', name=f.name.value, url=f.url.value, \
                      description=f.desc.value, vars=dict(id=id))
            return web.seeother('/links/')
        else:
            d['f'] = f
            d['linkId'] = id
            return render.linkEdit(**d)

class linkDel(object):
    @login_required
    def GET(self, id):
        if id:
            db.delete('links', where='id=$id', vars=dict(id=id))

        return web.seeother('/links/')


