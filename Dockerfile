# Minecraft 1.8.7 Dockerfile - Example with notes


# Use the offical Centos Docker image with latest version tag
FROM centos:latest

MAINTAINER John Cercurati <https://github.com/jcercurati>

# Use yum to download Java Runtime Envirronment, a dependency to run Minecraft.
RUN yum update -y \
  && yum clean all
RUN yum install -y \
  java-1.7.0-openjdk-headless \
  wget \
  && yum clean all

# Download Minecraft Server components
RUN wget -q https://s3.amazonaws.com/Minecraft.Download/versions/1.8.7/minecraft_server.1.8.7.jar

# Sets working directory for the CMD instruction (also works for RUN, ENTRYPOINT commands)
# Create mount point, and mark it as holding externally mounted volume
WORKDIR /data
VOLUME /data

# Expose the container's network port: 25565 during runtime.
EXPOSE 25565

# Automatically accept Minecraft EULA, and start Minecraft server
CMD echo eula=true > /data/eula.txt && java -jar /minecraft_server.1.8.7.jar
