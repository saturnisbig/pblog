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
from models import *
from sqlalchemy.orm import scoped_session, sessionmaker
from sqlalchemy import func
from config.settings import contentLength, recentPostNum

d = dict()

def get_tags():
    return web.ctx.orm.query(Tag).order_by('tags.name').all()

def get_links():
    return web.ctx.orm.query(Link).order_by('links.name').all()

def get_categories():
    return web.ctx.orm.query(Category).order_by('categories.name').all()

def get_recent_posts():
    return web.ctx.orm.query(Entry).order_by('entries.createdTime desc')[:recentPostNum]

def load_sqla(handler):
    web.ctx.orm = scoped_session(sessionmaker(bind=engine))
    d['categories'] = get_categories()
    d['tags'] = get_tags()
    d['links'] = get_links()
    d['recentPosts'] = get_recent_posts()

    try:
        return handler()
    except web.HTTPError:
        web.ctx.orm.commit()
        raise
    except:
        web.ctx.orm.rollback()
        raise
    finally:
        web.ctx.orm.commit()
        # if the above alone doesn't work, uncomment the following line.
        #web.ctx.orm.expunge_all()

def my_hook():
    pass
    #d['categories'] = db.select('categories')
    #d['tags'] = db.select('tags')
    #d['links'] = db.select('links')


class index(object):
    def GET(self):
        #return render.index()
        #sql = "select en.id AS entryId, en.title, en.slug, en.content, en.createdTime, c.name AS cat, en.viewNum, en.commentNum from entries en LEFT JOIN categories c ON en.categoryId = c.id ORDER BY en.createdTime asc"
        #entries = list(db.query(sql))
        #for entry in entries:
        #    entry.tags = db.query("select * from tags t left join entry_tag et on t.id=et.tagId where et.entryId=$id", vars={'id': entry.entryId})
        entries = web.ctx.orm.query(Entry).order_by(Entry.id).all()
        #print entries
        #for entry in entries:
        #    cutPos = contentLength
        #    if entry.content[contentLength] != u' ':
        #        cutPos = entry.content.find(u' ', contentLength)
        #        print cutPos, contentLength
        #    entry.content = entry.content[:cutPos] + '......'
            #print entry.content
            #for t in entry.tags:
            #    print 'tags:', t.name
        #for entry in entries:
        #    entry.tags = web.ctx.orm.query(entry_tag).join(Tag).filter(entry_tag.entry_id=entry.id)

        d['entries'] = entries
        d['contentLength'] = contentLength
        return render.index(**d)

class entry(object):

    def get_entry(self, slug):
        entry = web.ctx.orm.query(Entry).filter(Entry.slug == slug).all()
        #entry = list(db.query("select en.id, en.title, en.slug, en.content, en.createdTime AS createdTime, c.name AS cat, en.commentNum, en.viewNum from entries en LEFT JOIN categories c ON en.categoryId = c.id where en.slug=$slug", vars={'slug': slug}))
        #for one in entry:
        #    one.tags = db.query("select * from tags t LEFT JOIN entry_tag et ON t.id = et.tagId WHERE et.entryId = $id", vars={'id': one.id})
        #    one.comments = db.query("SELECT * FROM comments c WHERE c.entryId=$id", vars={'id': one.id})

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
            #preEntry = list(db.query('SELECT slug FROM entries WHERE id = (SELECT \
            #                         max(id) FROM entries WHERE id < %d)' % int(entry.id)))
            # preEntry is a tuple.
            preEntry = web.ctx.orm.query(Entry).filter(Entry.id < entry.id).order_by("entries.id desc").all()
            #print preEntry[0][1].id, preEntry[0][1].slug
            nextEntry = web.ctx.orm.query(Entry).filter(Entry.id > entry.id).order_by(Entry.id).all()
            #print nextEntry[0][1].id, nextEntry[0][1].title, entry.id
            #nextEntry = list(db.query('SELECT slug FROM entries WHERE id = (SELECT \
            #                          min(id) FROM entries WHERE id > %d)' % int(entry.id)))
            # update the viewNum
            entry.viewNum = entry.viewNum + 1
            #db.query('UPDATE entries SET viewNum = viewNum + 1 WHERE id=%d' % int(entry.id))
            #preEntry = db.select('entries', what='slug', where='id=%d' % (int(entry.id) + 1))
            #posEntry = db.select('entries', what='slug', where='id=%d' % (int(entry.id) + 1))
            d['entry'] = entry
            if preEntry:
                d['preEntry'] = preEntry[0]
            else:
                d['preEntry'] = None

            if nextEntry:
                #d['nextEntry'] = nextEntry[0][1]
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
                #createdTime = datetime.now().strftime("%Y-%m-%d %H:%M")
                #db.insert('comments', entryId=i.entryId, email=i.email, username=i.username, url=i.url, comment=i.comment,createdTime=createdTime)
                #db.update('entries', where = 'id=%s' % entry.entryId, commentNum = entry.commentNum + 1)
            comment = Comment(i.email, i.username, i.url, i.comment, entry.id)
            web.ctx.orm.add(comment)
            entry.commentNum = entry.commentNum + 1
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
        #ts = web.ctx.orm.query(Tag).filter(Tag.name == tag).all()
        #tags = []
        #for t in ts:
        #    print t.entries
        #    tags.append(t.name)
        #entry_has_tag = []
        #entries = web.ctx.orm.query(Entry).all()
        #for entry in entries:
        #    for t in entry.tags:
        #        if t.name in tags:
        #            entry_has_tag.append(entry)

        #d['entries'] = entry_has_tag
        tags = web.ctx.orm.query(Tag).filter(Tag.name == tag).all()
        entries = tags[0].entries
        d['entries'] = entries
        d['slug'] = tag

        return render.tag(**d)
    #raise web.seeother("/404/")

class category(object):
    def GET(self, slug):
        #entries = list(db.query("select en.id AS entryId, en.title, en.slug, en.content, en.createdTime, c.name AS cat, en.commentNum from entries en LEFT JOIN categories c ON en.categoryId=c.id where c.name=$c", vars={'c': c}))
        entries = web.ctx.orm.query(Entry).join(Category).filter(Category.slug == slug).filter(Entry.categoryId == Category.id).all()
        d['entries'] = entries
        d['slug'] = slug
        return render.category(**d)

class addComment(object):
    def POST(self):
        i = web.input()
        if i.url == "":
            i.url = "#"
            #createdTime = datetime.now().strftime("%Y-%m-%d %H:%M")
            comment = Comment(i.email, i.username, i.url, i.comment, )
            db.insert('comments', entryId=i.id, email=i.email, username=i.username, url=i.url, comment=i.comment,createdTime=createdTime)
            entry = db.select('entries',what='commentNum', where='id=%s' % i.id)
            db.update('entries', where = 'id=%s' % i.entryId, commentNum = entry[0].commentNum + 1)
            d['d'] = i
            d['createdTime'] = createdTime

        return render.comment(**d)

class pageNotFound(object):
    def GET(self):
        return render.pageNotFound()
