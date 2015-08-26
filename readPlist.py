
import os
import sys
import commands
import pipes
import xml.etree.ElementTree as ET
import plistlib
import StringIO



infoPlistPath = sys.argv[1]
commands.getoutput('plutil -convert xml1 "{}" '.format(infoPlistPath))
info = plistlib.readPlist(infoPlistPath)
URLArray = info['CFBundleURLTypes']

resultString=""

for item in URLArray:
    resultString = resultString + item['CFBundleURLSchemes'][0] + ','

print resultString
#plistlib.writePlist(info,infoPlistPath)
#commands.getoutput('plutil -convert binary1 "{}" '.format(infoPlistPath))
