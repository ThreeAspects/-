#Ԥ����һ
#set java hadoop env
export JAVA_HOME=/usr
export JRE_HOME=$JAVA_HOME/jre
export HADOOP_HOME=/opt/hadoop-2.9.1
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/lib:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

#Ԥ�����������
preprocess_class="hive.mr.pre.WeblogPreProcess"

#��������־��ŵ�Ŀ¼
log_pre_input=/data/weblog/preprocess/output

#Ԥ����������Ŀ¼
log_pre_output=/data/weblog/preprocess/output

#��ȡʱ����Ϣ
day_01=`date -d'-l day' +%Y-%m-%d`
syear=`date --date=$day_01 +%Y`
smonth=`date --date=$day_01 +%m`
sday=`date --date=$day_01 +%d`

#��ȡ��־�ļ���Ŀ¼���ж��Ƿ��е��մ������Ŀ¼
files=`hadoop fs -ls $log_pre_input | grep $day_01 | wc -l`
if [ $files -gt 0]; then
#�ύmr����job����
hadoop jar weblog.jar $preprocess_class $log_pre_input/$day_01 $log_pre_output/$day_01
fi