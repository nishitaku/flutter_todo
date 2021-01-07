#!/bin/zsh

APPLICATION_DATA_FOLDER=$1
cd ${APPLICATION_DATA_FOLDER}

for dir in *
do
 IDENTIFIER=$(/usr/libexec/PlistBuddy -c "print :MCMMetadataIdentifier" ${dir}/.com.apple.mobile_container_manager.metadata.plist)
 if [ ${IDENTIFIER} = "com.example.flutterTodo" ] ; then
  cd -
  echo "${APPLICATION_DATA_FOLDER}/${dir}"
  exit 0
 fi
done
