#!/usr/bin/env python
# coding: utf-8
##
##
import web
from config.settings import render, db
from datetime import datetime
import time
from cache import mcache

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
        sql = "select en.id AS entry_id, en.title AS entry_title, en.slug AS entry_slug, en.content AS entry_content, en.created_time AS entry_created_time, c.name AS entry_category, en.comment_num from entries en LEFT JOIN categories c ON en.category_id = c.id ORDER BY en.created_time asc"
        entries = list(db.query(sql))
        for entry in entries:
            entry.tags = db.query("select * from tags t left join entry_tag et on t.id=et.tag_id where et.entry_id=$id", vars={'id': entry.entry_id})
        #for entry in entries:
        #    category = db.select('categories', where="id=$id", vars={'id': entry.category_id})
        #    if category:
        #        entry.category = category[0].name
        categories = db.select('categories')
        tags = db.select('tags')
        links = db.select('links')
        d['entries'] = entries
        #d['categories'] = categories
        #d['tags'] = tags
        #d['links'] = links
        return render.index(**d)

class entry(object):
    def GET(self, slug):
        #entry = list(db.select('entries', where="slug=$slug", vars={'slug': slug}))
        entry = list(db.query("select en.id AS entry_id, en.title AS entry_title, en.slug AS entry_slug, en.content AS entry_content, en.created_time AS entry_created_time, c.name AS entry_category, en.comment_num from entries en LEFT JOIN categories c ON en.category_id = c.id where en.slug=$slug", vars={'slug': slug}))
        entry[0].tags = db.query("select * from tags t LEFT JOIN entry_tag et ON t.id = et.tag_id WHERE et.entry_id = $id", vars={'id': entry[0].entry_id})
        #for one in entry:
        #    one.tags = db.query("select * from tags t left join entry_tag et on et.tag_id=t.id where et.entry_id=$id", vars={'id':one.entry_id})
        comments = db.query("SELECT * FROM comments c WHERE c.entry_id=$id", vars={'id': entry[0].entry_id})
        d['entry'] = entry[0]
        if len(comments) > 0:
            d['comments'] = comments
        return render.entry(**d)

class page(object):
    def GET(self):
        pass

class tag(object):
    def GET(self, tag):
        ids = list(db.query("select entry_id as id from entry_tag et left join \
                            tags t on et.tag_id = t.id where t.name=$tag", vars={'tag': tag}))
        entry_ids = [str(i['id']) for i in ids]
        entries = list(db.query("select en.id AS entry_id, en.title AS entry_title, en.slug AS entry_slug, en.content AS entry_content, en.created_time AS entry_created_time, c.name AS entry_category, en.comment_num from entries en LEFT JOIN categories c ON en.category_id=c.id where en.id in ($ids)", vars={'ids': ','.join(entry_ids)}))

        d['entries'] = entries
        d['slug'] = tag
        return render.tag(**d)
        #raise web.seeother("/404/")

class category(object):
    def GET(self, c):
        entries = list(db.query("select en.id AS entry_id, en.title AS entry_title, en.slug AS entry_slug, en.content AS entry_content, en.created_time AS entry_created_time, c.name AS entry_category, en.comment_num from entries en LEFT JOIN categories c ON en.category_id=c.id where c.name=$c", vars={'c': c}))
        d['entries'] = entries
        d['slug'] = c
        return render.category(**d)

class addComment(object):
    def POST(self):
        i = web.input()
        created_time = datetime.now().strftime("%Y-%m-%d %H:%M")
        if i.url == "":
            i.url = "#"
        db.insert('comments', entry_id=i.id, email=i.email, username=i.username, url=i.url, comment=i.comment,created_time=created_time)
        entry = db.select('entries',what='comment_num', where='id=%s' % i.id)
        db.update('entries', where = 'id=%s' % i.id, comment_num = entry[0].comment_num + 1)
        d['d'] = i
        d['created_time'] = created_time

        return render.comment(**d)

class pageNotFound(object):
    def GET(self):
        return render.pageNotFound()
