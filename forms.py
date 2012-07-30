#!/usr/bin/env python
# coding: utf-8

import web
from web import form
from config.settings import db

usernameValidator = form.regexp(r".{3,15}$", "must be between 3 and 15 characters.")
emailValidator = form.regexp(r".*@.*", "must be a valid email address.")


entryForm = form.Form(
        form.Textbox('title', form.notnull),
        form.Textbox('slug', form.notnull),
        form.Textbox('category_id', form.notnull),
        form.Textarea('content', form.notnull),
    )

commentForm = form.Form(
        form.Textbox('username', usernameValidator, description='用户名'),
        form.Textbox('email', emailValidator, description='电子邮箱'),
        form.Textarea('comment', form.notnull, description='评论内容'),
        form.Textbox('createdTime', description='发表时间'),
        form.Button('submit', type='submit', html=u'提交')
    )

tagForm = form.Form(
        form.Textbox('name', form.notnull, description=u'标签'),
        form.Textbox('entry_num', description=u'文章数'),
        form.Button('submit', type='submit', html=u'提交')
    )
