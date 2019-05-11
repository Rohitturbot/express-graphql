#!/bin/bash
echo "lorem ipsum"
echo "HACKTHON >>>>>>>>>>>>>"
function main {
  echo "hhhhh"
  # repo_clone $@
  pushed_files $@
  echo "<><><><><><><><><><><><><><><><><>ASADSADASDASDSA><><><><><><><>"
}
function repo_clone {
	mkdir turbot-test-v5
  echo "directory changed"
	cd turbot-test-v5
	git clone https://github.com/turbotio/turbot-core.git
	git clone https://github.com/turbotio/turbot-mods.git
  echo "repo cloned"
	cd turbot-core
	npm i
	cd ../turbot-mods
	npm i --only=dev
	npm run init #check needed
  echo "over"
}

function pushed_files {
	echo "Started"
  commit_id=$CODEBUILD_RESOLVED_SOURCE_VERSION
  git branch
	# git checkout $branch_name
  echo ">>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<"
	git checkout $commit_id
  echo "subham suggestions"
  echo ">>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<"
	if [[ `git diff --name-only master $commit_id` ]];
  then
   	echo "Files got changed"
    # FILES=`git diff --name-only master $commit_id`
    FILES=(packages/aws-acm/src/turbot.yml packages/aws-ecs/functions/rupesh/cmdb/index.js)
  	echo $FILES
    # for i in {1..5}
    # do
    #   echo "Welcome $i times"
    # done
  	for val in ${FILES[@]};
    do
  	#   path=$(cut -d'/' -f 1-2 <<<$val)
    #   echo ">>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<"
    #   echo $path
    #   echo ">>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<"
  	# 	cd $path
    #   pwd
    #   echo ">>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<"
    #   echo backchodi chal rahi hai bhai
  	# 	# turbot inspect

      echo ">>>>>>>>>>>>>>>>>>>>>HAVA CHAL RAHI HAI <<<<<<<<<<<<<<"
  	# 	if [ "$?" -ne "0" ]
  	# 	then
    # 		error_msg "inspect not running"
    # 		error+="$path service package has error"
  	# 	fi
    #   # cd ../../
    done
  fi
  # git checkout master
}

function error_msg {
  RED='\e[31m'
  OFF='\e[0m'
  echo -e "${RED}ERROR: $1 ${OFF}"
}
main $@