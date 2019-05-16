#�ƶ����ݵ�Ԥ������Ŀ¼
#set java hadoop env
export JAVA_HOME=/usr
export JRE_HOME=$JAVA_HOME/jre
export HADOOP_HOME=/opt/hadoop-2.9.1
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/lib:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

#flume�ɼ����ɵ���־�ļ���ŵ�Ŀ¼/data/flumedata/
log_flume_dir=data/flumedata/

#Ԥ�������Ĺ���Ŀ¼
log_pre_input=/data/weblog/preprocess/input

#��ȡʱ����Ϣ
day_01=`date -d'-l day' +%Y-%m-%d`
syear=`date --date=$day_01 +%Y`
smonth=`date --date=$day_01 +%m`
sday=`date --date=$day_01 +%d`

#��ȡ��־�ļ���Ŀ¼���ж��Ƿ�����Ҫ�ϴ����ļ�
files=`hadoop fs -ls $log_flume_dir | grep $day_01 | wc -l`
if[$files gt 0 ];then
hadoop fs -mv ${log_flume_dir}/${day_01} ${log_pre_input}
echo "success"
fi