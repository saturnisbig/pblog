#!/usr/bin/env python
# coding: utf-8
import web
from config.url import urls
from controllers.views import my_hook, load_sqla

app = web.application(urls, globals())

if web.config.get('_session') is None:
    session = web.session.Session(app, web.session.DiskStore('sessions'),\
                                  initializer = {'isAdmin': 0, 'userId': 2, 'username': ''})

    web.config._session = session
else:
    session = web.config._session

#web.template.Template.globals['context'] = web.config._session

def session_hook():
    # make session work with sub-app.
    web.ctx.session = session
    # make session work under tpl.
    #web.template.Template.globals['session'] = session


# session hook, use with sub-app.
app.add_processor(web.loadhook(session_hook))

#app.add_processor(web.loadhook(my_hook))
app.add_processor(load_sqla)

if __name__ == "__main__":
    app.internalerror = web.debugerror
    app.run()
