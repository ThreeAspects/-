#Ԥ�����
#set java hadoop env
export JAVA_HOME=/usr
export JRE_HOME=$JAVA_HOME/jre
export HADOOP_HOME=/opt/hadoop-2.9.1
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/lib:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

#�����pageviewsģ��Ԥ�����������
click_pv_class="hive.mr.my.ClickStream"
#�����pageviewsģ�ͳ�������Ŀ¼����Ԥ����������Ŀ¼
log_pre_output=/data/weblog/preprocess/output
#�����pageviewsģ�ʹ���������Ŀ¼
click_pvout=/data/weblog/preprocess/click_pv_out

#�����visitģ��Ԥ�����������
click_visit_class="hive.mr.my.ClickStreamVisit"
#�����visitģ��Ԥ�����������Ŀ¼����pageviewsģ��Ԥ����������Ŀ¼
#�����pageviewsģ�ʹ���������Ŀ¼
click_vstout=/data/weblog/preprocess/click_visit_out

#��ȡʱ����Ϣ
day_01=`date -d'-l day' +%Y-%m-%d`
syear=`date --date=$day_01 +%Y`
smonth=`date --date=$day_01 +%m`
sday=`date --date=$day_01 +%d`

#��ȡ��־�ļ���Ŀ¼���ж��Ƿ��е��մ������Ŀ¼
files=`hadoop fs -ls $log_pre_output | grep $day_01 | wc -l`
if [ $files -gt 0]; then
#�ύmr����job����
hadoop jar weblog.jar $click_pv_class $log_pre_output/$day_01 $click_pvout/$day_01
fi
echo "pv�������н���� $?"
if [ $? -eq 0]; then
#�ύmr����job����
hadoop jar weblog.jar $click_visit_class $click_pvout/$day_01 $click_vstout/$day_01
fi