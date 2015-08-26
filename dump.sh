#!/bin/bash

cd `dirname $0`


outputCSVName="result.csv"

foreachfile()
{
	filename=`basename "$1"`
	echo 
	echo "find a file "$filename
	tempDirName=$filename".dir"
	tempDirPath="./ipa/$tempDirName"

	#unzip ipa to $tempDirPath
	mkdir $tempDirPath
	tar -zxf $1 -C $tempDirPath


	#read find plist
	plistPath=`find $tempDirPath/Payload/ -depth 2 -iname Info.plist`

	echo "get a plist "$plistPath
	schemeList=`python readPlist.py $plistPath`

	echo "read scheme "$schemeList

	echo "$tempDirName"",""$schemeList" >> $outputCSVName
}


#remove old file
find . -name *.dir -exec rm -rf {} \;

echo "file,scheme" > $outputCSVName

for j in `find ./ipa -name *.ipa`
do
echo $j
foreachfile $j
done





