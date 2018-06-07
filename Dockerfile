FROM maven:alpine
WORKDIR /app
COPY ./app /app
CMD mvn spring-boot:run
