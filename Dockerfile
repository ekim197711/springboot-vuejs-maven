FROM alpine:latest AS builder
RUN apk add --no-cache wget tar npm
RUN mkdir /workdir
WORKDIR /workdir
RUN wget https://cdn.azul.com/zulu/bin/zulu14.28.21-ca-jdk14.0.1-linux_musl_x64.tar.gz
RUN tar -xvf zulu14.28.21-ca-jdk14.0.1-linux_musl_x64.tar.gz
RUN ln -s /workdir/zulu14.28.21-ca-jdk14.0.1-linux_musl_x64/bin/java /usr/bin/java
RUN ln -s /workdir/zulu14.28.21-ca-jdk14.0.1-linux_musl_x64/bin/javac /usr/bin/javac
ENV JAVA_HOME /workdir/zulu14.28.21-ca-jdk14.0.1-linux_musl_x64/
RUN java --version; javac --version
COPY ./ ./
RUN ./mvnw clean package

FROM alpine:latest
RUN apk add --no-cache wget tar
RUN mkdir /myapp
WORKDIR /myapp
RUN wget https://cdn.azul.com/zulu/bin/zulu14.28.21-ca-jre14.0.1-linux_musl_x64.tar.gz
RUN tar -xvf zulu14.28.21-ca-jre14.0.1-linux_musl_x64.tar.gz
RUN apk del wget tar
COPY --from=builder /workdir/target/app.jar .
CMD ["/myapp/zulu14.28.21-ca-jre14.0.1-linux_musl_x64/bin/java","-jar","/myapp/app.jar"]