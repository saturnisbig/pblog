#!/usr/bin/env python
# coding: utf-8

from sqlalchemy import create_engine, Table, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, Text, DateTime
from sqlalchemy import func
from sqlalchemy.orm import relationship, backref
from datetime import datetime


engine = create_engine('sqlite:///blog.db', echo=True)

Base = declarative_base()
metadata = Base.metadata


class User(Base):
    __tablename__ = 'users'
    # the length is referenced when calling CREATE TABLE
    id = Column(Integer(11), primary_key=True)
    username = Column(String(100))
    passwd = Column(String(50))

    def __init__(self, username, passwd):
        self.username = username
        self.passwd = passwd

class Address(Base):
    __tablename__ = 'addresses'
    id = Column(Integer, primary_key=True)
    email_address = Column(String)
    user_id = Column(Integer, ForeignKey('users.id'))

    user = relationship("User", backref=backref('addresses', order_by=id))


if __name__ == "__main__":
    metadata.create_all(bind=engine)
