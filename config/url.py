#!/usr/bin/env python
# coding: utf-8

pre_fix = 'controllers.'

# urls example.
urls = (
    '/',                pre_fix + 'views.index',
    '^/entry/(.*)/$',   pre_fix + 'views.entry',
    '^/page/(.*)/$',    pre_fix + 'views.page',
    '^/tag/(.*)/$',     pre_fix + 'views.tag',
)
