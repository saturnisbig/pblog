#!/usr/bin/env python
# coding: utf-8

import web
from web.contrib.template import render_mako
import os, memcache

pageCount = 10

db = web.database(dbn = 'mysql', db='pblog', user='root', pw='root')

# memcache
mc = memcache.Client(['127.0.0.1:11211'], debug=0)

render = render_mako(
    directories=[os.getcwd() + '/templates'],
    input_encoding='utf-8',
    output_encoding='utf-8',
    )

