# Usar una imagen base de OpenJDK
FROM openjdk:11-jre-slim

# Crear un grupo y un usuario no root
RUN groupadd -r shippinggroup && useradd -r -g shippinggroup -m -s /bin/sh shippinguser

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo JAR de la aplicación al contenedor
COPY target/shipping-service-example-0.0.1-SNAPSHOT-spring-boot.jar /app/shipping-service-example.jar

# Cambiar la propiedad del archivo JAR para el nuevo usuario
RUN chown shippinguser:shippinggroup shipping-service-example.jar

# Cambiar al nuevo usuario no root
USER shippinguser

ENTRYPOINT ["java", "-jar", "shipping-service-example.jar"]
