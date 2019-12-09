#find tomcat
var=$(sudo find / -name "version.sh")
if [[ -z "$var" ]];then
mkdir /home/ec2-user/apache
cd /home/ec2-user/apache
#download tomcat
sudo yum install java



#downloading tomcat
wget http://apachemirror.wuchna.com/tomcat/tomcat-8/v8.5.49/bin/apache-tomcat-8.5.49.tar.gz



#unzipping tar file 
tar -xvzf apache-tomcat-8.5.49.tar.gz

#delete tar file
rm -rf apache-tomcat-8.5.49.tar.gz

#changing the port for tomcat
sed -i "s/port=\"8080\"/port=\"8888\"/" apache-tomcat-8.5.49/conf/server.xml


#tomcat-users
sed -i 's\</tomcat-users>\<!-- -->\g' apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '<role rolename="manager-gui" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '<user username="admin" password="admin" roles="manager-gui" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '<role rolename="manager-script" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '<user username="script" password="script" roles="manager-script" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
echo '</tomcat-users>' >> apache-tomcat-8.5.49/conf/tomcat-users.xml


#setting valve in comments

sed -i 's/<Valve /<!-- <Valve /' apache-tomcat-8.5.49/webapps/manager/META-INF/context.xml

sed -i 's\:1" />\:1" /> -->\g' apache-tomcat-8.5.49/webapps/manager/META-INF/context.xml

#running tomcat
apache-tomcat-8.5.49/bin/./startup.sh


cd ..

cp /$JENKINS_HOME/$JOB_NAME/ /home/ec2-user/apache/apache-tomcat-8.5.49/webapps/

