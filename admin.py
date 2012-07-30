#!/usr/bin/env python
# coding: utf-8

import web

pre_fix = 'controllers.'

urls_admin = (
    '/$', pre_fix + 'adminviews.index',
    '/entries/', pre_fix + 'adminviews.entries',
    '/entry/edit/(.*)/$', pre_fix + 'adminviews.entryEdit',
    '/entry/del/(.*)/', pre_fix + 'adminviews.entryDel',
    '/comments/',   pre_fix + 'adminviews.comments',
    '/comment/edit/(.*)/', pre_fix + 'adminviews.commentEdit',
    '/comment/del/(.*)/', pre_fix + 'adminviews.commentDel',
    '/tags/',       pre_fix + 'adminviews.tags',
    '/tag/edit/(.*)/', pre_fix + 'adminviews.tagEdit',
    '/tag/del/(.*)/', pre_fix + 'adminviews.tagDel',
    '/categories/', pre_fix + 'adminviews.categories',
    '/category/edit/(.*)/', pre_fix + 'adminviews.categoryEdit',
    '/category/del/(.*)/', pre_fix + 'adminviews.categoryDel',
    '/links/',  pre_fix + 'adminviews.links',
    '/link/edit/(.*)/', pre_fix + 'adminviews.linkEdit',
    '/link/del/(.*)/', pre_fix + 'adminviews.linkDel',
)

app_admin = web.application(urls_admin, locals())
