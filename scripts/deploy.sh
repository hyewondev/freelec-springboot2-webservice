#!/bin/bash

REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=freelec-springboot2-webservice

echo "> Build copy file"

cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo "> check pid of application is running"

CURRENT_PID=$(pgrep -fl freelec-springboot2-webservice | grep jar | awk '{print $1}')

echo "> running application pid: $CURRENT_PID"

if [ -z "$CURRENT_PID" ]; then
  echo "> No appication running, no stop"
else
  echo "> kill -15 $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

echo "> build new application"

JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1


echo "> JAR Name: $JAR_NAME"

echo "> add permission on $JAR_NAME"

chmod +x $JAR_NAME

echo "> run $JAR_NAME"

nohup java -jar \
    -Dspring.config.location=classpath:/application.properties,classpath:/applixation-real.properties,/home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real-db.properties \
    -Dspring.profiles.active=real \
    $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &

