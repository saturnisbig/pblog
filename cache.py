#!/usr/bin/env python
# coding: utf-8

from config.settings import mc

class MCache(object):

    def set(self, name, value):
        return mc.set(name, pickle.dumps(value))

    def get(self, name):
        value = mc.get(name)
        if value is not None:
            return pickle.loads(value)
        return None

    def delete(self, name):
        return mc.delete(name)

mcache = MCache()
