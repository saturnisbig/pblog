#!/usr/bin/env python
#-*-coding:utf-8-*-

#from BeautifulSoup import BeautifulSoup
#soup = BeautifulSoup('<html><p>abc</p><script></script><br />abc</html>')
#for tag in soup.recursiveChildGenerator():
#    if hasattr(tag, 'name') and tag.name in ['script', 'iframe']:
#        tag.extract()
#print soup.renderContents('utf-8')

from markdown import markdown

def content(value):
    return markdown(value)
