FROM maven:3.9.9-eclipse-temurin-17 AS builder
WORKDIR /workspace
COPY pom.xml .
RUN mvn -B -q dependency:go-offline
COPY src src
RUN mvn -B -q clean package -DskipTests

FROM eclipse-temurin:17-jre-noble
RUN useradd --system --uid 10001 --create-home gateway && mkdir -p /app/config /var/log/device-gateway /opt/hikvision/isup && chown -R gateway:gateway /app /var/log/device-gateway /opt/hikvision
WORKDIR /app
COPY --from=builder /workspace/target/device-protocol-gateway-*.jar app.jar
ENV SPRING_CONFIG_ADDITIONAL_LOCATION=file:/app/config/ \
    LD_LIBRARY_PATH=/opt/hikvision/isup:/opt/hikvision/isup/lib
USER gateway
EXPOSE 8080 7660
ENTRYPOINT ["java","-XX:MaxRAMPercentage=75","-jar","/app/app.jar"]
