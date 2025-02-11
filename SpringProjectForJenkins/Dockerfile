# FROM ubuntu:22.04
FROM chan0yeol/sprimg-tomcat-app:1.2

# ubuntu에 필수 패키지 설치
# RUN apt-get update && apt-get install -y openjdk-17-jdk git maven unzip curl
RUN apt-get install -y curl

# 외부에서 제공하는 압축파일을 ADD 
RUN mkdir -p /home/spring/jks && curl -L https://codeload.github.com/chan0yeol/jenkins/zip/refs/heads/main -o /home/spring/jks/main.zip

#RUN ls -lh /home/spring/jks/main.zip && file /home/spring/jks/main.zip

# apache-tomcat 파일 ADD
# ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.98/bin/apache-tomcat-9.0.98.tar.gz /home/tomcat/

# Application과 Tomcat 압축해제 및 Maven 빌드 실행
RUN unzip /home/spring/jks/*.zip -d /home/spring/jks/

# RUN tar -xf /home/tomcat/apache-tomcat-9.0.98.tar.gz -C /home/tomcat/
RUN mvn -f /home/spring/jks/jenkins-main/SpringProjectForJenkins/pom.xml clean package

# WAR 파일을 Tomcat의 webapp 폴더로 이동
RUN mv /home/spring/jks/jenkins-main/SpringProjectForJenkins/target/*.war /home/tomcat/apache-tomcat-9.0.98/webapps/

WORKDIR /home/tomcat/apache-tomcat-9.0.98
# tomcat 서버 실행
ENTRYPOINT ["/home/tomcat/apache-tomcat-9.0.98/bin/catalina.sh", "run"]