#!/bin/bash
uncrustify --show-config > default_uncrustify.cfg
# 将 uncrustify.cfg与default_uncrustify.cfg进行合并产生new_uncrustify.cfg
python update_uncrustify.py
rm uncrustify_old.cfg
mv uncrustify.cfg uncrustify_old.cfg
mv new_uncrustify.cfg uncrustify.cfg
rm default_uncrustify.cfg
