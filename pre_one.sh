#预处理一
#set java hadoop env
export JAVA_HOME=/usr
export JRE_HOME=$JAVA_HOME/jre
export HADOOP_HOME=/opt/hadoop-2.9.1
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/lib:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

#预处理程序类名
preprocess_class="hive.mr.pre.WeblogPreProcess"

#待处理日志存放的目录
log_pre_input=/data/weblog/preprocess/output

#预处理输出结果目录
log_pre_output=/data/weblog/preprocess/output

#获取时间信息
day_01=`date -d'-l day' +%Y-%m-%d`
syear=`date --date=$day_01 +%Y`
smonth=`date --date=$day_01 +%m`
sday=`date --date=$day_01 +%d`

#读取日志文件的目录，判断是否有当日待处理的目录
files=`hadoop fs -ls $log_pre_input | grep $day_01 | wc -l`
if [ $files -gt 0]; then
#提交mr任务job运行
hadoop jar weblog.jar $preprocess_class $log_pre_input/$day_01 $log_pre_output/$day_01
fi