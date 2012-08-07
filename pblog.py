#!/usr/bin/env python
# coding: utf-8
import web
from config.url import urls
from controllers.views import my_hook

app = web.application(urls, globals())

if web.config.get('_session') is None:
    session = web.session.Session(app, web.session.DiskStore('sessions'),\
                                  initializer = {'isAdmin': 0})

    web.config._session = session
else:
    session = web.config._session

def session_hook():
    web.ctx.session = session

# session hook, use with sub-app.
app.add_processor(web.loadhook(session_hook))

app.add_processor(web.loadhook(my_hook))

if __name__ == "__main__":
    app.internalerror = web.debugerror
    app.run()
