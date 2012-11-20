#!/usr/bin/env python
# coding: utf-8

import web
from web.contrib.template import render_mako
import os
#import os, memcache


#db = web.database(dbn = 'mysql', db='pb', user='root', pw='root')

# memcache
#mc = memcache.Client(['127.0.0.1:11211'], debug=0)

# blog content abbrevation length 29/10/12 22:39:37
contentLength = 100
entryPerPage = 5
recentPostNum = 10

render = render_mako(
    directories=[os.getcwd() + '/templates/mako'],
    input_encoding='utf-8',
    output_encoding='utf-8',
    # import custom filters.
    imports=['from libs.filter import content'],
    )

render_admin = render_mako(
    directories = [os.getcwd() + '/templates/mako/admin'],
    input_encoding = 'utf-8',
    output_encoding = 'utf-8',
    )

