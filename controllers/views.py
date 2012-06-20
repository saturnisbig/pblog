#!/usr/bin/env python
# coding: utf-8
##
##
import web
from config.settings import render, db
import time
from cache import mcache

datas = dict()

def get_posts():
    pass

def my_hook():
    datas['categories'] = db.select('categories')
    datas['tags'] = db.select('tags')
    datas['links'] = db.select('links')


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
        datas['entries'] = entries
        #datas['categories'] = categories
        #datas['tags'] = tags
        #datas['links'] = links
        return render.index(**datas)

class entry(object):
    def GET(self, slug):
        #entry = list(db.select('entries', where="slug=$slug", vars={'slug': slug}))
        entry = list(db.query("select en.id AS entry_id, en.title AS entry_title, en.slug AS entry_slug, en.content AS entry_content, en.created_time AS entry_created_time, c.name AS entry_category, en.comment_num from entries en LEFT JOIN categories c ON en.category_id = c.id where en.slug=$slug", vars={'slug': slug}))
        for one in entry:
            one.tags = db.query("select * from tags t left join entry_tag et on et.tag_id=t.id where et.entry_id=$id", vars={'id':one.entry_id})
            #one.category = db.query("select * from categories c where c.id=$id", vars={'id': one.category_id})
        datas['entry'] = entry[0]
        return render.entry(**datas)

class page(object):
    def GET(self):
        pass

class tag(object):
    def GET(object):
        pass

