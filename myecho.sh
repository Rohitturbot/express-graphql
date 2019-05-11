#!/bin/bash
echo "jkjknjnkjn"
function main {
  echo "hhhhh"
  # repo_clone $@
  pushed_files $@
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
  # cd ../
  # cd express-graphql
	# branch_name='add-aws-ec2-cmdb'
  commit_id=$CODEBUILD_RESOLVED_SOURCE_VERSION
  git branch
  branch_name=`git branch --contains $commit_id`
  echo $branch_name
  echo $commit_id
	git checkout $branch_name
  echo "subham suggestions"
  git branch
	if [[ `git diff --name-only master $branch_name` ]];
  then
   	echo "Files got changed"
    FILES=`git diff --name-only master $branch_name`
  	echo $FILES
  	for val in $FILES;
    do
  	  path=$(cut -d'/' -f 1-2 <<<$val)
      echo $path
  		cd $path
      pwd
      echo backchodi chal rahi hai bhai
  		# turbot inspect
  		# if [ "$?" -ne "0" ]
  		# then
    	# 	error_msg "inspect not running"
    	# 	error+="$path service package has error"
  		# fi
      # cd ../../
    done
  fi
  git checkout master
}

function error_msg {
  RED='\e[31m'
  OFF='\e[0m'
  echo -e "${RED}ERROR: $1 ${OFF}"
}
main $@