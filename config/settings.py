#!/usr/bin/env python
# coding: utf-8

import web
from web.contrib.template import render_mako
import os


db = web.database(dbn = 'mysql', db='pblog', user='root', pw='root')

render = render_mako(
    directories=[os.getcwd() + '/templates'],
    input_encoding='utf-8',
    output_encoding='utf-8',
    )

