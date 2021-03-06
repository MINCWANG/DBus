#!/bin/sh

#获得当前shell所在路径
basepath=$(cd `dirname $0`; pwd)
#echo $basepath
echo "****************************************** starting *****************************************"
#jvm启动参数
#GC_OPTS="-XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCApplicationStoppedTime -Xloggc:/data/dbus-canal-auto/logs/gc/gc.log"
LOG_CONF="-Dlogs.base.path=$basepath -Duser.dir=$basepath"
OOM_OPTS="-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=$basepath/logs/oom"
JVM_OPTS="-server -Xmx80m -Xms40m -XX:NewRatio=1"
CLASS_PATH=""
MAIN="com.creditease.dbus.ogg.auto.Start"
if [ "x$1" = "xmaster" ]
then
        MAIN="com.creditease.dbus.ogg.auto.OGGDeploy"
fi

#导入jar和config进入classpath
for i in $basepath/lib/*.jar;
        do CLASS_PATH=$i:"$CLASS_PATH";
done
export CLASS_PATH=.:$CLASS_PATH

java $JVM_OPTS $LOG_CONF $OOM_OPTS -classpath $CLASS_PATH $MAIN
