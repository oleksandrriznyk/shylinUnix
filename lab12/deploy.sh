#!/bin/bash


function log_info {
    msg=$1
    now=$(date)
    echo '' $now '[INFO]' $msg
}

function log_err {
    msg=$1
    now=$(date)
    echo '' $now '[ERROR]' $msg
}

function mvn {
echo '[INFO]' maven
}

proj_dir=$1
app_name=$2


tomcat=${CATALINA_HOME}

log_info 'CATALINA_HOME is '$tomcat 

# check if maven installed
#if ! hash mvn 2> /dev/null; then
if $(mvn) > /dev/null; then
    log_err 'Maven not installed. Exiting...' 
    exit 1
fi

# check if pom.xml is in folder
if [ ! -f $proj_dir/pom.xml ] ; then
    log_err 'Folder '$artifact' does not contain pom.xml' 
    exit 1
fi

log_info 'Maven project found at '$proj_dir
log_info 'Building...' 

mvn -f $proj_dir clean compile package
#$(mvn clean compile package)
rc=$?

# exit if build finished with not 0 code
if [ $rc -ne 0 ]; then
    log_err 'Build failed. Exiting...' 
    exit $rc
fi

# getting artifact and putting it to tomcat
war=$(find $proj_dir -name '*.war' -type f)
rc=$?

if [ ! $rc ]; then
    log_err 'War artifact to found. Exiting...' 
    exit 1
fi

log_info 'Artifact found at '$war
log_info 'Deploying artifact '$war'... '

dep_path=$tomcat'/webapps/'
final_war=$dep_path'/'$app_name'.war'

mv $war $final_war

unzip $final_war -d $dep_path/$app_name

log_info 'Artifact '$war' has been successfully deployed' 

exit 0


#for i in $(dpkg --list | grep -v ^ii | awk '{ print $2 }'); do sudo apt-get purge $i; done
