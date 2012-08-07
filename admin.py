#!/usr/bin/env python
# coding: utf-8

import web

pre_fix = 'controllers.'

urls_admin = (
    '/$', pre_fix + 'adminviews.index',
    '/login/', pre_fix + 'adminviews.login',
    '/logout/', pre_fix + 'adminviews.logout',
    '/entries/', pre_fix + 'adminviews.entries',
    '/entry/add/', pre_fix + 'adminviews.entryAdd',
    '/entry/edit/(.*)/$', pre_fix + 'adminviews.entryEdit',
    '/entry/del/(.*)/', pre_fix + 'adminviews.entryDel',
    '/comments/',   pre_fix + 'adminviews.comments',
    '/comment/edit/(.*)/', pre_fix + 'adminviews.commentEdit',
    '/comment/del/(.*)/', pre_fix + 'adminviews.commentDel',
    '/tags/',       pre_fix + 'adminviews.tags',
    '/tag/add/', pre_fix + 'adminviews.tagAdd',
    '/tag/edit/(.*)/', pre_fix + 'adminviews.tagEdit',
    '/tag/del/(.*)/', pre_fix + 'adminviews.tagDel',
    '/categories/', pre_fix + 'adminviews.categories',
    '/category/add/', pre_fix + 'adminviews.categoryAdd',
    '/category/edit/(.*)/', pre_fix + 'adminviews.categoryEdit',
    '/category/del/(.*)/', pre_fix + 'adminviews.categoryDel',
    '/links/',  pre_fix + 'adminviews.links',
    '/link/add/', pre_fix + 'adminviews.linkAdd',
    '/link/edit/(.*)/', pre_fix + 'adminviews.linkEdit',
    '/link/del/(.*)/', pre_fix + 'adminviews.linkDel',
)

app_admin = web.application(urls_admin, locals())
