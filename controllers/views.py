#!/usr/bin/env python
# coding: utf-8
##
##
import web
from config.settings import render, db

class index(object):
    def GET(self):
        return render.index()
