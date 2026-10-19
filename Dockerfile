# Dockerfile cho dự án "Bản Đồ Tết Việt" (Đề Tài C05)
# Sử dụng multi-stage build để tối ưu kích thước image

# ============================
# STAGE 1: Build JAR với Maven
# ============================
FROM eclipse-temurin:17-jdk-alpine AS builder

WORKDIR /app

# Copy file cấu hình Maven trước (tối ưu cache layer)
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Download dependencies (cache lại nếu pom.xml không đổi)
RUN chmod +x mvnw && ./mvnw dependency:go-offline -B

# Copy toàn bộ mã nguồn và build
COPY src src
RUN ./mvnw package -DskipTests -B

# ============================
# STAGE 2: Runtime Image nhẹ
# ============================
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy WAR đã build từ stage 1 (JSP hoạt động đúng trong WAR)
COPY --from=builder /app/target/*.war app.war

# Expose port
EXPOSE 8080

# Khởi chạy ứng dụng Spring Boot (Executable WAR)
ENTRYPOINT ["java", "-jar", "app.war"]
