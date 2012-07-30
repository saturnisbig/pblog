#!/usr/bin/env python
# coding: utf-8

from config import settings
import web
from forms import *


db = settings.db
render = settings.render_admin

datas = dict()

class index(object):
    def GET(self):
        entryNum = list(db.query("SELECT COUNT(id) as num from entries"))
        catNum = list(db.query("SELECT COUNT(id) as num from categories"))
        tagNum = list(db.query("SELECT COUNT(id) as num from tags"))
        commentNum = list(db.query("SELECT COUNT(id) as num from comments"))
        linkNum = list(db.query("SELECT COUNT(id) as num from links"))

        datas['entryNum'] = entryNum[0].num
        datas['categoryNum'] = catNum[0].num
        datas['tagNum'] = tagNum[0].num
        datas['commentNum'] = commentNum[0].num
        datas['linkNum'] = linkNum[0].num
        return render.index(**datas)

class entries(object):
    def GET(self):
        entries = list(db.query("SELECT title AS entry_title, created_time, \
                                id, modified_time FROM entries ORDER BY id DESC"))
        datas['entries'] = entries
        return render.entries(**datas)

class entryEdit(object):

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

    def GET(self, id):
        entry = list(db.select('entries', where="id=$id", vars={'id': id}))[0]

        if len(entry) > 0:
            f = entryForm()
            f.title.value = entry.title
            f.slug.value = entry.slug
            #f.category_id.value = entry.category_id
            #f.content.value = entry.content
            categories = list(db.select('categories'))
            tags = list(db.query("SELECT t.name AS name FROM tags t LEFT JOIN \
                                 entry_tag et ON t.id = et.tag_id WHERE et.entry_id \
                                 = $id", vars={'id': id}))
            entry.tags = ",".join(t.name for t in tags)

            datas['entry'] = entry
            datas['categories'] = categories
            datas['f'] = f

        return render.entryEdit(**datas)

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
                print tagsAdd, tagsDel

                if tagsAdd:
                    # add some tags in new entry
                    for t in tagsAdd:
                        t_id = ''
                        tagExists = list(db.select('tags', what='id, entry_num', \
                                              where='name=$n', vars={'n': t}))
                        if tagExists:
                            db.update('tags', where='name=$n', entry_num = \
                                      tagExists[0].entry_num + 1, vars = {'n': t})
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
                            print 'tag deleted:', t_id, t

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
            return web.seeother('/entries/')
        else:
            datas['f'] = f
            datas['entry'] = entry
            return render.entryEdit(**datas)


class entryDel(object):
    def GET(self, id):
        # delete the comment reference
        db.query("DELETE FROM comments WHERE entry_id=$id", vars={'id': id})
        # delete the entry_tag table
        #et = list(db.query("SELECT * FROM entry_tag WHERE entry_id=$id", vars={'id': id}))
        db.query("DELETE FROM entry_tag WHERE entry_id=$id", vars={'id': id})
        #for t in et:
        #    db.query("DELETE FROM tags WHERE id=$tag_id", vars={'tag_id': t.tag_id})
        db.query("DELETE FROM entries WHERE id=$id", vars={'id': id})
        return web.seeother('/entries/')

class comments(object):
    def GET(self):
        #c = list(db.select('comments'))
        comments = list(db.select('comments'))
        datas['comments'] = comments
        return render.comments(**datas)

class commentEdit(object):
    def GET(self, id):
        cmt = list(db.select('comments', where='id=$id', vars={'id': id}))[0]
        f = commentForm()
        f.username.value = cmt['username']
        f.email.value = cmt['email']
        f.comment.value = cmt['comment']
        f.createdTime.value = cmt['created_time']
        datas['f'] = f
        # get the cmt id for post.
        datas['cmtId'] = cmt['id']
        return render.commentEdit(**datas)

    def POST(self, id):
        f = commentForm()
        if f.validates():
            db.update('comments', where='id=$id', comment=f.comment.value, vars={'id': id})
            return web.seeother('/comments/')
        else:
            datas['f'] = f
            datas['cmtId'] = id
            return render.commentEdit(**datas)

class commentDel(object):
    def GET(self, id):
        db.delete('comments', where='id=$id', vars={'id': id})
        return web.seeother('/comments/')

class tags(object):
    def GET(self):
        tags = list(db.select('tags'))
        datas['tags'] = tags
        return render.tags(**datas)

class tagEdit(object):
    def GET(self, id):
        f = tagForm()
        tag = list(db.select('tags', where='id=$id', vars={'id': id}))[0]
        f.name.value = tag['name']
        f.entry_num.value = tag['entry_num']
        datas['f'] = f
        datas['tId'] = tag['id']
        return render.tagEdit(**datas)

    def POST(self, id):
        f = tagForm()
        if f.validates():
            db.update('tags', where='id=$id', name=f.name.value, entry_num=f.entry_num.value, \
                      vars={'id': id})
            return web.seeother('/tags/')
        else:
            datas['f'] = f
            datas['tId'] = id
            return render.tagEdit(**datas)

class tagDel(object):
    def GET(self, id):
        print id
        db.delete('entry_tag', where='tag_id=$id', vars={'id': id})
        db.delete('tags', where='id=$id', vars={'id': id})
        return web.seeother('/tags/')

class categories(object):
    def GET(self):
        cats = list(db.select('categories'))
        datas['cats'] = cats
        return render.categories(**datas)

class categoryEdit(object):
    def GET(self, id):
        pass

    def POST(self, id):
        pass

class categoryDel(object):
    def GET(self, id):
        pass


class links(object):
    def GET(self):
        pass

