# Dockerfile cho dự án "Bản Đồ Tết Việt" (Đề Tài C05)
# Dùng image Maven chính thức (đã có sẵn Maven, không cần tải thêm)

# ============================
# STAGE 1: Build WAR với Maven
# ============================
FROM maven:3.9.6-eclipse-temurin-17-alpine AS builder

WORKDIR /app

# Copy file cấu hình Maven trước (tối ưu cache layer)
COPY pom.xml .

# Download dependencies trước (cache layer riêng để build nhanh hơn)
RUN mvn dependency:go-offline -B

# Copy toàn bộ mã nguồn và build WAR
COPY src src
RUN mvn package -DskipTests -B

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
