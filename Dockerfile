FROM tomcat:10.1-jdk17-temurin

WORKDIR /app

COPY src/main/webapp /app/webapp
COPY src/main/java /app/java

RUN mkdir -p /app/webapp/WEB-INF/classes

RUN javac \
    -cp "/usr/local/tomcat/lib/*:/app/webapp/WEB-INF/lib/*" \
    -d /app/webapp/WEB-INF/classes \
    $(find /app/java -name "*.java")

RUN rm -rf /usr/local/tomcat/webapps/ROOT \
    && cp -r /app/webapp /usr/local/tomcat/webapps/ROOT

EXPOSE 8080

CMD ["catalina.sh", "run"]