# -*- coding: utf-8 -*-
#!/usr/bin/env python3

import os

def updateKeyValue(line, result):
    # key = value # comm
    key = line[:line.find('=')].strip()
    if key in result:
        value = line[line.find('=')+1:line.find('#')].strip()
        result[key] = value

def getKeyValue(line, result):
    key = line[:line.find('=')].strip()
    value = line[line.find('=')+1:line.find('#')].strip()
    result[key] = value

# old config
memap = {}
with open("uncrustify.cfg", "r") as bkcfg:
    for line in bkcfg.readlines():
        line = line.strip()
        if ((line == '') or (line[0]=='#')):
            continue
        getKeyValue(line, memap)

# this is current uncrustify's defaults confiture of new version
cfglines = []
with open("default_uncrustify.cfg", "r") as mecfg:
    for line in mecfg.readlines():
        line = line.strip()
        if (line == ''):
            continue

        if line[0] == '#':
            cfglines.append(line)
            continue

        # if it's not comment line, get key and value
        key = line[:line.find('=')].strip()
        # find key in memap, and if find, replace value, or use new value
        # In the new configure, this key is removed!
        if key not in memap:
            cfglines.append(line)
            continue

        if (len(memap[key])>0) and (memap[key] != '""'):
            value = memap[key]
            #  print(key + " : " + value)
        else:
            value = line[line.find('=')+1:line.find('#')].strip()

        comment = line[line.find('#'):].strip()
        #  print(comment)
        newline = key + "=" + value + "    " + comment
        cfglines.append(newline)

# output
with open("new_uncrustify.cfg", "w+") as newcfg:
    newcfg.writelines([line+'\n' for line in cfglines])

if __name__ == '__main__':
    pass
