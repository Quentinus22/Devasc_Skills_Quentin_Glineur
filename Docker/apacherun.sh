#!/bin/bash

# Build Docker Image
docker build -t apache-image .

# Run Docker Container
docker run -d -p 5555:5555 --name apache-container pache-image