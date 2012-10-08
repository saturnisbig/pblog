#!/usr/bin/env python
# coding: utf-8

from sqlalchemy import create_engine, Table, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, Text, DateTime
from sqlalchemy import func
from sqlalchemy.orm import relationship, backref
from datetime import datetime


engine = create_engine('sqlite:///test.db', echo=True)

Base = declarative_base()
metadata = Base.metadata

entry_tag = Table('entry_tag', Base.metadata,
                 Column('entry_id', Integer, ForeignKey('entries.id')),
                 Column('tag_id', Integer, ForeignKey('tags.id')),
                 )

class User(Base):
    __tablename__ = 'user'
    # the length is referenced when calling CREATE TABLE
    id = Column(Integer(11), primary_key=True)
    username = Column(String(100))
    passwd = Column(String(50))

    def __init__(self, username, passwd):
        self.username = username
        self.passwd = passwd

class Entry(Base):
    __tablename__ = 'entries'
    id = Column(Integer(11), primary_key = True)
    title = Column(String)
    slug = Column(String)
    content = Column(Text)
    viewNum = Column(Integer, default=1)
    commentNum = Column(Integer, default=0)
    createdTime = Column(DateTime, default = datetime.now())
    modifiedTime = Column(DateTime)
    categoryId = Column(Integer, ForeignKey('categories.id'))

    category = relationship("Category", backref=backref('entries', order_by=id))
    # relation with tags, many-to-many,
    tags = relationship("Tag", secondary=entry_tag, backref='entries')

class Category(Base):
    __tablename__ = 'categories'

    id = Column(Integer, primary_key=True)
    name = Column(String)
    slug = Column(String)
    entryNum = Column(Integer)
    createdTime = Column(DateTime, default = datetime.now())
    modifiedTime = Column(DateTime)

    #entries = relationship("Entry", backref='categories')

class Comment(Base):
    __tablename__ = 'comments'

    id = Column(Integer, primary_key=True)
    email = Column(String)
    username = Column(String)
    url = Column(String)
    comment = Column(Text)
    createdTime = Column(DateTime, default=datetime.now())
    entryId = Column(Integer, ForeignKey('entries.id'))

    entry = relationship("Entry", backref=backref('comments', order_by=id))

class Tag(Base):
    __tablename__ = 'tags'

    id = Column(Integer, primary_key=True)
    name = Column(String)
    entryNum = Column(Integer, default=0)

    #entries = relationship('Entry', secondary=entry_tag, backref='tags')

class Link(Base):
    __tablename__ = 'links'

    id = Column(Integer, primary_key=True)
    name = Column(String)
    url = Column(String)
    description = Column(String)
    createdTime = Column(DateTime, default=datetime.now())

class Admin(Base):
    __tablename__ = 'admins'

    id = Column(Integer, primary_key=True)
    username = Column(String)
    passwd = Column(String)

