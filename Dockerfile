# 베이스 이미지로 Tomcat 이미지 사용
FROM chan0yeol/sprimg-tomcat-app:1.2

# 필수 패키지 설치 (curl, git, openjdk-17-jdk 등)
RUN apt-get update && apt-get install -y curl

# 작업 디렉터리 생성
WORKDIR /home/spring

# Git에서 소스를 클론하여 빌드
RUN git clone https://github.com/chan0yeol/jenkins.git

# Spring 프로젝트 디렉터리로 이동하여 Maven 빌드 실행
WORKDIR /home/spring/jenkins/SpringProjectForJenkins

# Maven을 사용해 프로젝트 빌드 (clean package)
RUN mvn clean package

# WAR 파일을 Tomcat webapps 폴더로 이동
RUN mv target/*.war /home/tomcat/apache-tomcat-9.0.98/webapps/

# Tomcat 서버 실행
WORKDIR /home/tomcat/apache-tomcat-9.0.98
ENTRYPOINT ["/home/tomcat/apache-tomcat-9.0.98/bin/catalina.sh", "run"]
