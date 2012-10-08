#!/usr/bin/env python
# coding: utf-8

from config import settings
import web
from forms import *
from datetime import datetime
import hashlib
from models import *



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
            #print passwd
            #admin = list(db.select('users', what='passwd', where='username="%s"' \
            #                       % i.get('username')))
            #print admin[0].passwd
            admin = web.ctx.orm.query(User.passwd).filter(User.username == i.username).all()
            if len(admin) > 0:
                if passwd == admin[0].passwd:
                    web.ctx.session.isAdmin = 1
                    raise web.seeother('/')
            else:
                errs = 'username/passwd error.'
                d['f'] = f
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
        #entryNum = list(db.query("SELECT COUNT(id) as num from entries"))
        #catNum = list(db.query("SELECT COUNT(id) as num from categories"))
        #tagNum = list(db.query("SELECT COUNT(id) as num from tags"))
        #commentNum = list(db.query("SELECT COUNT(id) as num from comments"))
        #linkNum = list(db.query("SELECT COUNT(id) as num from links"))
        entryNum = web.ctx.orm.query(Entry).count()
        catNum = web.ctx.orm.query(Category).count()
        tagNum = web.ctx.orm.query(Tag).count()
        commentNum = web.ctx.orm.query(Comment).count()
        linkNum = web.ctx.orm.query(Link).count()

        d['entryNum'] = entryNum
        d['categoryNum'] = catNum
        d['tagNum'] = tagNum
        d['commentNum'] = commentNum
        d['linkNum'] = linkNum
        #d['entryNum'] = entryNum[0].num
        #d['categoryNum'] = catNum[0].num
        #d['tagNum'] = tagNum[0].num
        #d['commentNum'] = commentNum[0].num
        #d['linkNum'] = linkNum[0].num
        return render.index(**d)

class entries(object):
    @login_required
    def GET(self):
        #entries = list(db.query("SELECT title, createdTime, \
        #                        id, modifiedTime FROM entries ORDER BY id DESC"))
        entries = web.ctx.orm.query(Entry).order_by(Entry.id).all()
        d['entries'] = entries
        return render.entries(**d)

class entryAdd(object):
    @login_required
    def GET(self):
        # specify the selected columns when query the db.
        #what = 'id, name, entryNum'
        #cats = list(db.select('categories', what=what))
        cats = web.ctx.orm.query(Category).order_by(Category.id).all()
        d['categories'] = cats
        return render.entryAdd(**d)

    @login_required
    def POST(self):
        f = entryForm()
        print f.validates()
        i = web.input(tags=None)
        catId = i['categoryId']
        if f.validates():
            #entryId = db.insert('entries', title=i['title'], slug=i['slug'], categoryId=catId, \
            #                    modifiedTime=datetime.now(), createdTime=datetime.now(), content=i['content'])
            # print i['tags'] == None, type(i['tags']), len(i['tags'])
            entry = Entry(i.title, i.slug, i.content, catId)
            web.ctx.orm.add(entry)
            if entry.id:
                entryNum = entry.category.entryNum
                #db.query("update categories set entryNum = entryNum +1 where id=%d" % int(catId))
                entry.category.entryNum = entryNum + 1

            # i['tags'] == [''] != None, so use len(i['tags']) instead.
            if len(i['tags']) > 0:
                tags = [i.strip() for i in i['tags'].split(',')]
                for t in tags:
                    #tmpTag = db.select('tags', what='id', where='name="%s"' % t).list()
                    tmpTag = web.ctx.orm.query(Tag).filter(Tag.name == t).all()
                    if len(tmpTag) > 0:
                        #db.insert('entry_tag', entryId=entryId, tagId=tmpTag[0].id)
                        #db.query("UPDATE tags SET entryNum = entryNum + 1 WHERE id=%d" % tmpTag[0].id)
                        tmpTag[0].entryNum = tmpTag[0].entryNum + 1
                        entry.tags.append(tmpTag[0])
                    else:
                        #t_id = db.insert('tags', name=t, entryNum=1)
                        newTag = Tag(t, 1)
                        web.ctx.orm.add(newTag)
                        entry.tags.append(newTag)
                        #db.insert('entry_tag', entryId=entryId, tagId=t_id)
            return web.seeother('/entries/')

        else:
            return web.seeother('/entry/add/')


class entryEdit(object):

    @login_required
    def get_entry(self, id):
        """
        get the entry with tags included. if entry not empty return it else return None.
        """
        return web.ctx.orm.query(Entry).filter(Entry.id == id).first()
        #entry = list(db.select('entries', where="id=$id", vars={'id': id}))
        #entry = web.ctx.orm.query(Entry).filter(Entry.id == id).first()
        #if len(entry) > 0:
        #    entry = entry[0]
        #    #tags = list(db.query("SELECT t.name AS name FROM tags t LEFT JOIN \
        #    #                     entry_tag et ON t.id = et.tagId WHERE et.entryId \
        #    #                     = $id", vars={'id': id}))
        #    #entry.tags = ",".join(t.name for t in tags)
        #    return entry
        #else:
        #    return None

    @login_required
    def GET(self, id):
        entry = self.get_entry(id)

        if entry is not None:
            f = entryForm()
            f.title.value = entry.title
            f.slug.value = entry.slug
            entry.tagList = ",".join([t.name for t in entry.tags])
            categories = web.ctx.orm.query(Category).all()
            #f.categoryId.value = entry.categoryId
            #f.content.value = entry.content
            #categories = list(db.select('categories', what='id, name, entryNum'))
            #tags = list(db.query("SELECT t.name AS name FROM tags t LEFT JOIN \
            #                     entry_tag et ON t.id = et.tagId WHERE et.entryId \
            #                     = $id", vars={'id': id}))
            #entry.tags = ",".join(t.name for t in tags)
            d['entry'] = entry
            d['categories'] = categories
            d['f'] = f

        return render.entryEdit(**d)

    @login_required
    def POST(self, id):
        entry = self.get_entry(id)
        f = entryForm()
        # set default value for some col in entries table
        i = web.input(title=None, slug=None, categoryId=None, tags=None)
        if f.validates():
            print "valid input."
            if i.tags is not None:
                newTags = set([t.strip() for t in i.tags.split(',')])
                origTags = set([t.name.strip() for t in entry.tags])
                # use filter to remove the empty string
                tagsAdd = filter(len, list(newTags - origTags))
                tagsDel = filter(len, list(origTags- newTags))
                #print 'tags add:', tagsAdd
                #print 'tags del:', tagsDel
                #tagsAdd = filter(lambda x: len(x) > 0, list(newTags - origTags))
                #tagsDel = filter(lambda x: len(x) > 0, list(origTags - newTags))
                #tagsAdd = list(origTags - newTags).remove('')
                #tagsDel = list(origTags - newTags).remove('')
                #print tagsAdd, tagsDel

                if tagsAdd:
                    # add some tags in new entry
                    for tag in tagsAdd:
                        t = ''
                        tagExists = web.ctx.orm.query(Tag).filter(Tag.name == tag).first()
                        #tagExists = list(db.select('tags', what='id, entryNum', \
                        #                           where='name=$n', vars={'n': t}))
                        if tagExists:
                            tagExists[0].viewNum = tagExists[0].viewNum + 1
                            entry.tags.append(tag)
                            #db.update('tags', where='name=$n', entryNum = \
                            #          tagExists[0].entryNum + 1, vars = {'n': t})
                            ##db.query("UPDATE tags SET entryNum = entry_num + 1 WHERE name='%s'" % t)
                            #t_id = tagExists[0].id
                        else:
                            entry.tags.append(Tag(tag, 1))
                            #t_id = db.insert('tags', name=t, entryNum = 1)
                        #print t_id
                        #db.insert('entry_tag', entryId=id, tagId = t_id)

                if tagsDel:
                    # delete some original tags in entry
                    for tag in tagsDel:
                        t = web.ctx.orm.query(Tag).filter(Tag.name == t).first()
                        if t:
                            if t.entryNum == 1:
                                web.ctx.orm.delete(t)
                            else:
                                t.entryNum = t.entryNum - 1
                            entry.tags.remove(t)

            #print entry.categoryId, i.categoryId
            if i.categoryId != entry.categoryId and int(entry.categoryId) > 0:
                if entry.category.entryNum > 0:
                    entry.category.entryNum = entry.category.entryNum - 1
                entry.categoryId = i.categoryId
                # commit to update the entry.category relationship
                web.ctx.orm.commit()
            entry.title = i.title
            entry.slug = i.slug
            entry.content = i.content
            entry.modifiedTime = datetime.now()
            entry.category.entryNum = entry.category.entryNum + 1
            return web.seeother('/entries/')
        else:
            print 'invalid input.'
            d['f'] = f
            d['entry'] = entry
            return render.entryEdit(**d)


class entryDel(object):
    @login_required
    def GET(self, id):
        entry = web.ctx.orm.query(Entry).filter(Entry.id == id).first()
        # delete the comment reference
        cmt = web.ctx.orm.query(Comment).filter(Comment.entryId == id).all()
        for one in cmt:
            web.ctx.orm.delete(one)
        #db.query("DELETE FROM comments WHERE entryId=$id", vars={'id': id})
        # update the categories table
        entry.category.entryNum = entry.category.entryNum - 1
        #catId = list(db.select('entries', what='categoryId', where='id=%d' % int(id)))
        #if catId:
        #    db.query("UPDATE categories SET entryNum = entryNum - 1 WHERE id=%d" % int(catId[0].categoryId))
        # set the tags table entryNum - 1
        if entry.tags:
            for tag in entry.tags:
                tag.entryNum = tag.entryNum - 1
        #tags = list(db.select('entry_tag', what='tagId', where='entryId=%d' % int(id)))
        #if tags:
        #    for one in tags:
        #        db.query("UPDATE tags SET entryNum = entryNum - 1 WHERE id=%d" % one.tagId)
        #        # delete the entry_tag table
        #        db.query("DELETE FROM entry_tag WHERE entryId=$id", vars={'id': id})
        #        #for t in et:
        #        #    db.query("DELETE FROM tags WHERE id=$tagId", vars={'tag_id': t.tag_id})
        #db.query("DELETE FROM entries WHERE id=$id", vars={'id': id})
        web.ctx.orm.delete(entry)
        return web.seeother('/entries/')

class comments(object):
    @login_required
    def GET(self):
        #c = list(db.select('comments'))
        #comments = list(db.select('comments', what='id, username, email, comment, createdTime'))
        comments = web.ctx.orm.query(Comment).all()
        #print c
        d['comments'] = comments
        return render.comments(**d)

class commentEdit(object):
    @login_required
    def GET(self, id):
        # first return a scalar, which is an object?
        cmt = web.ctx.orm.query(Comment).filter(Comment.id == id).first()
        #cmt = list(db.select('comments', where='id=$id', vars={'id': id}))[0]
        f = commentForm()
        f.username.value = cmt.username
        f.email.value = cmt.email
        f.comment.value = cmt.comment
        f.createdTime.value = cmt.createdTime
        d['f'] = f
        # get the cmt id for post.
        d['cmtId'] = cmt.id
        return render.commentEdit(**d)

    @login_required
    def POST(self, id):
        f = commentForm()
        cmt = web.ctx.orm.query(Comment).filter(Comment.id == id).first()
        if f.validates():
            #db.update('comments', where='id=$id', comment=f.comment.value, vars={'id': id})
            cmt.comment = f.comment.value
            return web.seeother('/comments/')
        else:
            d['f'] = f
            d['cmtId'] = id
            return render.commentEdit(**d)

class commentDel(object):
    @login_required
    def GET(self, id):
        cmt = web.ctx.orm.query(Comment).filter(Comment.id == id).first()
        cmt.entry.commentNum = cmt.entry.commentNum - 1
        web.ctx.orm.delete(cmt)
        #db.delete('comments', where='id=$id', vars={'id': id})
        return web.seeother('/comments/')

class tags(object):
    @login_required
    def GET(self):
        #tags = list(db.select('tags'))
        tags = web.ctx.orm.query(Tag).all()
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
            web.ctx.orm.add(Tag(i['name'], i['entryNum']))
            #db.insert('tags', name=i['name'], entryNum=i['entryNum'])
            return web.seeother('/tags/')
        else:
            d['f'] = f
            return render.tagAdd(**d)

class tagEdit(object):
    @login_required
    def GET(self, id):
        f = tagForm()
        tag = web.ctx.orm.query(Tag).filter(Tag.id == id).first()
        #tag = list(db.select('tags', where='id=$id', vars={'id': id}))[0]
        f.name.value = tag.name
        f.entryNum.value = tag.entryNum
        d['f'] = f
        d['tId'] = tag.id
        return render.tagEdit(**d)

    @login_required
    def POST(self, id):
        f = tagForm()
        if f.validates():
            tag = web.ctx.orm.query(Tag).filter(Tag.id == id).first()
            tag.name = f.name.value
            tag.entryNum = f.entryNum.value
            #db.update('tags', where='id=$id', name=f.name.value, entryNum=f.entryNum.value, \
            #          vars={'id': id})
            return web.seeother('/tags/')
        else:
            d['f'] = f
            d['tId'] = id
            return render.tagEdit(**d)

class tagDel(object):
    @login_required
    def GET(self, id):
        tag = web.ctx.orm.query(Tag).filter(Tag.id == id).first()
        for entry in tag.entries:
            entry.tags.remove(tag)
        web.ctx.orm.delete(tag)
        return web.seeother('/tags/')

class categories(object):
    @login_required
    def GET(self):
        #cats = list(db.select('categories'))
        cats = web.ctx.orm.query(Category).all()
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
            web.ctx.orm.add(Category(i.name, i.slug, i.entryNum, datetime.now(), datetime.now()))
            #db.insert('categories', name=i['name'], slug=i['slug'], entryNum=i['entryNum'],\
            #          createdTime=datetime.now(), modifiedTime=datetime.now())
            return web.seeother('/categories/')
        else:
            d['f'] = f
            return render.categoryAdd(**d)

class categoryEdit(object):
    @login_required
    def GET(self, id):
        f = catForm()
        #cat = list(db.select('categories', where='id=$id', vars={'id': id}))[0]
        cat = web.ctx.orm.query(Category).filter(Category.id == id).first()
        f.name.value = cat.name
        f.slug.value = cat.slug
        f.entryNum.value = cat.entryNum
        d['f'] = f
        d['catId'] = cat.id
        return render.categoryEdit(**d)

    @login_required
    def POST(self, id):
        f = catForm()
        cat = web.ctx.orm.query(Category).filter(Category.id == id).first()
        if f.validates():
            cat.name = f.name.value
            cat.slug = f.slug.value
            cat.entryNum = f.entryNum.value
            cat.modifiedTime = datetime.now()
            #db.update('categories', where='id=$id', name=f.name.value, slug=f.slug.value,\
            #          entryNum=f.entryNum.value, modifiedTime=datetime.now(), vars={'id': id})
            return web.seeother('/categories/')
        else:
            d['f'] = f
            d['catId'] = id
            return render.categoryEdit(**d)

class categoryDel(object):
    @login_required
    def GET(self, id):
        #entry = db.select('entries', what='slug', where='id=$id', vars={'id': id}).list()
        cat = web.ctx.orm.query(Category).filter(Category.id == id).first()
        # if category not empty, do not delete the category.
        # todo: add 'undefine' category, when delete a category, move those entries
        #       under this category to 'undefine' category.
        #if not len(entry) > 0:
        if len(cat.entries) > 0:
            uncat = web.ctx.orm.query(Category).filter(Category.id == 1).first()
            for entry in cat.entries:
                entry.categoryId = 1
                uncat.entryNum += 1
        web.ctx.orm.delete(cat)
        return web.seeother('/categories/')


class links(object):
    @login_required
    def GET(self):
        #links = list(db.select('links'))
        links = web.ctx.orm.query(Link).all()
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
            web.ctx.orm.add(Link(i.name, i.url, i.desc))
            #db.insert('links', name=i['name'], url=i['url'], description=i['desc'], \
            #          createdTime=datetime.now())
            return web.seeother('/links/')
        else:
            d['f'] = f
            return render.linkAdd(**d)

class linkEdit(object):
    @login_required
    def GET(self, id):
        f = linkForm()
        #lk = list(db.select('links', where='id=$id', vars=dict(id=id)))[0]
        lk = web.ctx.orm.query(Link).filter(Link.id == id).first()
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
            lk = web.ctx.orm.query(Link).filter(Link.id == id).first()
            lk.name, lk.url, lk.description = f.name.value, f.url.value, f.decs.value
            #db.update('links', where='id=$id', name=f.name.value, url=f.url.value, \
            #          description=f.desc.value, vars=dict(id=id))
            return web.seeother('/links/')
        else:
            d['f'] = f
            d['linkId'] = id
            return render.linkEdit(**d)

class linkDel(object):
    @login_required
    def GET(self, id):
        if id:
            lk = web.ctx.orm.query(Link).filter(Link.id == id).first()
            web.ctx.orm.delete(lk)
            #db.delete('links', where='id=$id', vars=dict(id=id))
        return web.seeother('/links/')


