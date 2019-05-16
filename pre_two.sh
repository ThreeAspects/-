#预处理二
#set java hadoop env
export JAVA_HOME=/usr
export JRE_HOME=$JAVA_HOME/jre
export HADOOP_HOME=/opt/hadoop-2.9.1
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/lib:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

#点击流pageviews模型预处理程序类名
click_pv_class="hive.mr.my.ClickStream"
#点击流pageviews模型程序输入目录，即预处理输出结果目录
log_pre_output=/data/weblog/preprocess/output
#点击流pageviews模型处理程序输出目录
click_pvout=/data/weblog/preprocess/click_pv_out

#点击流visit模型预处理程序类名
click_visit_class="hive.mr.my.ClickStreamVisit"
#点击流visit模型预处理程序输入目录，即pageviews模型预处理程序输出目录
#点击流pageviews模型处理程序输出目录
click_vstout=/data/weblog/preprocess/click_visit_out

#获取时间信息
day_01=`date -d'-l day' +%Y-%m-%d`
syear=`date --date=$day_01 +%Y`
smonth=`date --date=$day_01 +%m`
sday=`date --date=$day_01 +%d`

#读取日志文件的目录，判断是否有当日待处理的目录
files=`hadoop fs -ls $log_pre_output | grep $day_01 | wc -l`
if [ $files -gt 0]; then
#提交mr任务job运行
hadoop jar weblog.jar $click_pv_class $log_pre_output/$day_01 $click_pvout/$day_01
fi
echo "pv处理运行结果： $?"
if [ $? -eq 0]; then
#提交mr任务job运行
hadoop jar weblog.jar $click_visit_class $click_pvout/$day_01 $click_vstout/$day_01
fi