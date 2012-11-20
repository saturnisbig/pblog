#!/usr/bin/env python
#-*-coding:utf-8-*-

from HTMLParser import HTMLParser
import sys
reload(sys)
sys.setdefaultencoding('utf8')

class TplFilter(HTMLParser):

    def __init__(self):
        HTMLParser.__init__(self)
        self.content = ''
        self.startTag = ''
        self.endTag = ''
        self.tag = []
        self.attrValues = []
        self.tags = {
            'a': ['href', 'target', 'name'],
            #'img': ['src', 'alt'],
            'b': '',
            'strong': '',
            'em': '',
            'i': '',
            'ul': '',
            'li': '',
            'p': '',
        }

    def handle_starttag(self, tag, attrs):
        if tag in self.tags:
            self.tag.append(tag)
            #print 'startTag:', tag
            #print tag, self.tags[tag]
            if len(attrs) > 0:
                for attr, value in attrs:
                    if attr in self.tags[tag]:
                        self.attrValues.append(attr + '="' + value + '"')
                        #print attr, value
                        #attrValue += attr + '=' + '"' + value + '" '
                    else:
                        pass
                #self.startTag = '<' + tag + ' ' + attrValue + '>'
                #attrValue = ''
        #    else:
        #        self.startTag = '<' + tag + '>'
        #else:
        #    self.startTag = ''

    def handle_endtag(self, tag):
        pass
        #if tag in self.tags:
        #    #print 'endTag:', tag
        #    self.endTag = '</' + tag + '>'
        #    #print 'startTag:', self.startTag, 'endTag:', self.endTag
        #else:
        #    self.endTag = ''

    def handle_data(self, data):
        #print data
        #print 'startTag:', self.startTag, 'endTag:',self.endTag
        #if len(self.startTag) > 0:
        #    tmp = self.startTag + data + self.endTag
        #else:
        #    tmp = data
        #tmp = self.startTag + data + self.endTag
        tmp = ''
        if len(self.tag) > 0:
            #print len(data.strip())
            #print self.tag, ' '.join(self.attrValues)
            if len(data.strip()):
                #tmp = '<' + self.tag + ' ' + ' '.join(self.attrValues) + '>' + data + '</' + self.tag + '>'
                t = self.tag.pop()
                tmp = '<' + t + '>' + data + '</' + t + '>'
            else:
                tmp = '<' + self.tag + '>'
            #print tmp
            self.tag = ''
            self.attrValues = []
        else:
            tmp = data
        self.content.append(tmp)


import re

def strip_tags(html):
    """
    Python中过滤HTML标签的函数
    #>>> str_text=strip_tags("<font color=red>hello</font>")
    #>>> print str_text
    #hello
    """
    from HTMLParser import HTMLParser
    html = html.strip()
    html = html.strip("\n")
    result = []
    parser = HTMLParser()
    parser.handle_data = result.append
    parser.feed(html)
    parser.close()
    return ''.join(result)

import re
##过滤HTML中的标签
#将HTML中标签等信息去掉
#@param htmlstr HTML字符串.
def filter_tags(htmlstr):
    #先过滤CDATA
    re_cdata=re.compile('//<!\[CDATA\[[^>]*//\]\]>',re.I) #匹配CDATA
    #re_script=re.compile('<\s*script[^>]*>[^<]*<\s*/\s*script\s*>',re.I)#Script
    re_style=re.compile('<\s*style[^>]*>[^<]*<\s*/\s*style\s*>',re.I)#style
    re_br=re.compile('<br\s*?/?>')#处理换行
    re_h=re.compile('</?\w+[^>]*>')#HTML标签
    re_comment=re.compile('<!--[^>]*-->')#HTML注释
    s=re_cdata.sub('',htmlstr)#去掉CDATA
    #s=re_script.sub('',s) #去掉SCRIPT
    s=re_style.sub('',s)#去掉style
    s=re_br.sub('\n',s)#将br转换为换行
    s=re_h.sub('',s) #去掉HTML 标签
    s=re_comment.sub('',s)#去掉HTML注释
    #去掉多余的空行
    blank_line=re.compile('\n+')
    s=blank_line.sub('\n',s)
    s=replaceCharEntity(s)#替换实体
    return s

##替换常用HTML字符实体.
#使用正常的字符替换HTML中特殊的字符实体.
#你可以添加新的实体字符到CHAR_ENTITIES中,处理更多HTML字符实体.
#@param htmlstr HTML字符串.
def replaceCharEntity(htmlstr):
    CHAR_ENTITIES={'nbsp':' ','160':' ',
                'lt':'<','60':'<',
                'gt':'>','62':'>',
                'amp':'&','38':'&',
                'quot':'"','34':'"',}

    re_charEntity=re.compile(r'&#?(?P<name>\w+);')
    sz=re_charEntity.search(htmlstr)
    while sz:
        entity=sz.group()#entity全称，如>
        key=sz.group('name')#去除&;后entity,如>为gt
        try:
            htmlstr=re_charEntity.sub(CHAR_ENTITIES[key],htmlstr,1)
            sz=re_charEntity.search(htmlstr)
        except KeyError:
            #以空串代替
            htmlstr=re_charEntity.sub('',htmlstr,1)
            sz=re_charEntity.search(htmlstr)
    return htmlstr

def repalce(s,re_exp,repl_string):
    return re_exp.sub(repl_string,s)

#str = "<img /><a>srcd</a>hello</br><br/>"
#str = re.sub(r'</?\w+[^>]*>','',str)
#print str

def my_filter(html, savedTags):
    form BeautifulSoup import BeautifulSoup
    soup = BeautifulSoup(html)
    for tag in soup.recursiveChildGenerator():
        if hasattr(tag, 'name') and tag.name not in savedTags:
            tag.extract()

if __name__ == '__main__':
    tplFilter = TplFilter()
    with open('test.htm', 'r') as f:
        doc = f.read()
        content = filter_tags(doc)
        #tplFilter.feed(doc)
        #content = ''.join(tplFilter.content)
        #from BeautifulSoup import BeautifulSoup
        #soup = BeautifulSoup(content)
        #print soup.prettify()
        print content
        #print ''.join(tplFilter.content)
