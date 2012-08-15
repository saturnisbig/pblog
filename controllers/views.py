#!/usr/bin/env python
# coding: utf-8
##
##
import web
from config.settings import render, db
from datetime import datetime
import time
from cache import mcache
from forms import commentForm

d = dict()

def get_posts():
    pass

def my_hook():
    d['categories'] = db.select('categories')
    d['tags'] = db.select('tags')
    d['links'] = db.select('links')


class index(object):
    def GET(self):
        #return render.index()
        sql = "select en.id AS entryId, en.title, en.slug, en.content, en.createdTime, c.name AS cat, en.viewNum, en.commentNum from entries en LEFT JOIN categories c ON en.categoryId = c.id ORDER BY en.createdTime asc"
        entries = list(db.query(sql))
        for entry in entries:
            entry.tags = db.query("select * from tags t left join entry_tag et on t.id=et.tagId where et.entryId=$id", vars={'id': entry.entryId})
        #for entry in entries:
        #    category = db.select('categories', where="id=$id", vars={'id': entry.categoryId})
        #    if category:
        #        entry.category = category[0].name
        #categories = db.select('categories')
        #tags = db.select('tags')
        #links = db.select('links')
        #d['categories'] = categories
        #d['tags'] = tags
        #d['links'] = links
        d['entries'] = entries
        return render.index(**d)

class entry(object):

    def get_entry(self, slug):
        entry = list(db.query("select en.id, en.title, en.slug, en.content, en.createdTime AS createdTime, c.name AS cat, en.commentNum, en.viewNum from entries en LEFT JOIN categories c ON en.categoryId = c.id where en.slug=$slug", vars={'slug': slug}))
        for one in entry:
            one.tags = db.query("select * from tags t LEFT JOIN entry_tag et ON t.id = et.tagId WHERE et.entryId = $id", vars={'id': one.id})
            one.comments = db.query("SELECT * FROM comments c WHERE c.entryId=$id", vars={'id': one.id})

        if entry:
            return entry[0]
        else:
            return None

    def GET(self, slug):
        #entry = list(db.select('entries', where="slug=$slug", vars={'slug': slug}))
        #entry = list(db.query("select en.id AS entryId, en.title AS entry_title, en.slug AS entry_slug, en.content AS entry_content, en.createdTime AS entry_created_time, c.name AS entry_category, en.commentNum from entries en LEFT JOIN categories c ON en.categoryId = c.id where en.slug=$slug", vars={'slug': slug}))
        #entry[0].tags = db.query("select * from tags t LEFT JOIN entry_tag et ON t.id = et.tagId WHERE et.entryId = $id", vars={'id': entry[0].entry_id})
        ##for one in entry:
        ##    one.tags = db.query("select * from tags t left join entry_tag et on et.tagId=t.id where et.entryId=$id", vars={'id':one.entry_id})
        #comments = db.query("SELECT * FROM comments c WHERE c.entryId=$id", vars={'id': entry[0].entry_id})
        #if len(comments) > 0:
        #    d['comments'] = comments
        f = commentForm()
        entry = self.get_entry(slug)
        if entry:
            # select the previous and next entry of current entry.
            preEntry = list(db.query('SELECT slug FROM entries WHERE id = (SELECT \
                                     max(id) FROM entries WHERE id < %d)' % int(entry.id)))
            nextEntry = list(db.query('SELECT slug FROM entries WHERE id = (SELECT \
                                      min(id) FROM entries WHERE id > %d)' % int(entry.id)))
            # update the viewNum
            db.query('UPDATE entries SET viewNum = viewNum + 1 WHERE id=%d' % int(entry.id))
            #preEntry = db.select('entries', what='slug', where='id=%d' % (int(entry.id) + 1))
            #posEntry = db.select('entries', what='slug', where='id=%d' % (int(entry.id) + 1))
            d['entry'] = entry
            if preEntry:
                d['preEntry'] = preEntry[0]
            else:
                d['preEntry'] = None

            if nextEntry:
                d['nextEntry'] = nextEntry[0]
            else:
                d['nextEntry'] = None
            d['f'] = f
            return render.entry(**d)
        else:
            return render.pageNotFound(**d)

    def POST(self, slug):
        f = commentForm()
        entry = self.get_entry(slug)
        i = web.input()
        if f.validates():
            if i.url == "":
                i.url = "#"
                createdTime = datetime.now().strftime("%Y-%m-%d %H:%M")
                db.insert('comments', entryId=i.entryId, email=i.email, username=i.username, url=i.url, comment=i.comment,createdTime=createdTime)
                db.update('entries', where = 'id=%s' % entry.entryId, commentNum = entry.commentNum + 1)
                #d['f'] = f
                #d['entry'] = entry
                raise web.seeother('/entry/%s/' % slug)
            else:
                d['f'] = f
                d['entry'] = entry
                return render.entry(**d)

class page(object):
    def GET(self):
        pass

class tag(object):
    def GET(self, tag):
        ids = list(db.query("select entryId as id from entry_tag et left join \
                            tags t on et.tagId = t.id where t.name=$tag", vars={'tag': tag}))
        entryIds = [str(i['id']) for i in ids]
        entries = list(db.query("select en.id AS entryId, en.title, en.slug, en.content, en.createdTime, c.name AS cat, en.commentNum from entries en LEFT JOIN categories c ON en.categoryId=c.id where en.id in ($ids)", vars={'ids': ','.join(entryIds)}))

        d['entries'] = entries
        d['slug'] = tag
        return render.tag(**d)
    #raise web.seeother("/404/")

class category(object):
    def GET(self, c):
        entries = list(db.query("select en.id AS entryId, en.title, en.slug, en.content, en.createdTime, c.name AS cat, en.commentNum from entries en LEFT JOIN categories c ON en.categoryId=c.id where c.name=$c", vars={'c': c}))
        d['entries'] = entries
        d['slug'] = c
        return render.category(**d)

class addComment(object):
    def POST(self):
        i = web.input()
        if i.url == "":
            i.url = "#"
            createdTime = datetime.now().strftime("%Y-%m-%d %H:%M")
            db.insert('comments', entryId=i.id, email=i.email, username=i.username, url=i.url, comment=i.comment,createdTime=createdTime)
            entry = db.select('entries',what='commentNum', where='id=%s' % i.id)
            db.update('entries', where = 'id=%s' % i.entryId, commentNum = entry[0].commentNum + 1)
            d['d'] = i
            d['createdTime'] = createdTime

        return render.comment(**d)

class pageNotFound(object):
    def GET(self):
        return render.pageNotFound()
