#!/usr/bin/env python
# coding: utf-8

import admin

pre_fix = 'controllers.'

# urls example.
urls = (
    '/',                pre_fix + 'views.index',
    '/entry/(.*)/',   pre_fix + 'views.entry',
    '/category/(.*)/', pre_fix + 'views.category',
    '/page/(.*)/',    pre_fix + 'views.page',
    '/tag/(.*)/',     pre_fix + 'views.tag',
    '/add_comment/',    pre_fix + 'views.addComment',
    '/404/',            pre_fix + 'views.pageNotFound',
    '/admin',           admin.app_admin,
)

