#!/bin/bash

SONARQUBE_VERSION="9.9.3.79811"

# Check if unzip is installed
if ! command -v unzip &> /dev/null; then
    echo "unzip is not installed. Installing..."
    sudo yum install -y unzip
    echo "Sleeping for 5 seconds to allow unzip installation to complete..."
    sleep 5
fi

# Step 1: Download Community edition
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-${SONARQUBE_VERSION}.zip

# Step 2: Extract .zip file and navigate to bin folder
unzip sonarqube-${SONARQUBE_VERSION}.zip
cd sonarqube-${SONARQUBE_VERSION}/bin

# Step 3: Choose the appropriate folder based on the machine configuration
if [ "$(uname -m)" == "x86_64" ]; then
    cd ../linux-x86-64
else
    cd ../linux-x86-32
fi

# Step 4: Run StartSonar.sh
./sonar.sh start

# Step 5: Wait for the server to start and open the default browser
echo "Waiting for SonarQube server to start..."
sleep 60  # You may need to adjust the sleep duration based on your system

# Open browser to SonarQube
xdg-open http://localhost:9000/  # Adjust for your system if needed
