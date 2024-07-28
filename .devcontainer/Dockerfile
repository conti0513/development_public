# Use the official Ubuntu image as a base
FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    awscli

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
