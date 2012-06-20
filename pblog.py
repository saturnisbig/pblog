#!/usr/bin/env python
# coding: utf-8
import web
from config.url import urls
from controllers.views import my_hook

app = web.application(urls, globals())

app.add_processor(web.loadhook(my_hook))

if __name__ == "__main__":
    app.internalerror = web.debugerror
    app.run()
