#!/bin/bash

cd `dirname $0`


outputCSVName="result.csv"

foreachfile()
{
	echo 
	echo "find a file "$1

	tempDirPath="$1".dir

	#unzip ipa to $tempDirPath
	mkdir "$tempDirPath"

	tar -zxvf $1 -C "$tempDirPath" ./Payload/*.app/Info.plist 

	# #read find plist
	plistPath=`find "$tempDirPath/Payload/" -depth 2 -iname Info.plist`

	# echo "get a plist "$plistPath
	schemeList=`python readPlist.py "$plistPath"`

	echo "read scheme "$schemeList
	tempDirName=${tempDirPath:6}

	#push info to cvs file
	echo "$tempDirName"",""$schemeList" >> $outputCSVName

	#remove temp file
	rm -rf "$tempDirPath"
}


#remove old file
find . -name *.dir -exec rm -rf {} \;
echo -e "\xEF\xBB\xBF" > $outputCSVName
echo "file,scheme" >> $outputCSVName

ipaList=$(find ./ipa -name *.ipa)

IFS=$'\n'

for j in $ipaList
do
foreachfile $j
done





