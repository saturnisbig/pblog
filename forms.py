#!/usr/bin/env python
# coding: utf-8

import web
from web import form

usernameValidator = form.regexp(r".{3,15}$", "must be between 3 and 15 characters.")
emailValidator = form.regexp(r".*@.*", "must be a valid email address.")

commentForm = form.Form(
        form.Textbox('username', usernameValidator, description=u'用户名'),
        form.Textbox('email', emailValidator, description=u'邮箱地址'),
        form.Textarea('content', form.notnull, description=u'留言内容'),
        form.Textbox('url', description=u'个人网站'),
        form.Button('submit', type='submit', html=u'留言'),
    )

loginForm = form.Form(
        form.Textbox('username', form.notnull, usernameValidator, description=u"用户名："),
        form.Password('passwd', form.notnull, description=u"密码："),
        form.Button('submit', type='submit', html=u'提交')
    )

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

catForm = form.Form(
        form.Textbox('name', form.notnull, description=u'类别'),
        form.Textbox('slug', form.notnull, description=u'slug'),
        form.Textbox('entry_num', description=u'文章数'),
        form.Button('submit', type='submit', html=u'提交')
    )

# with form.Validator() you can specified the error message.
linkForm = form.Form(
    form.Textbox('name', form.Validator("名称需要", lambda i: not (i == "")), description=u'链接名称'),
        form.Textbox('url', form.notnull, description=u'链接地址'),
        form.Textbox('desc', form.notnull, description=u'链接描述'),
        form.Button('submit', type='submit', html=u'提交')
    )
