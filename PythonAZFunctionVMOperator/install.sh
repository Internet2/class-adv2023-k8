#!/bin/bash
# Get the directory containing the script
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd $SCRIPT_DIR
# Creat the .env file from the template
cp .env-template .env
# Create virtual environment
python3 -m venv ../azureFunctionsEnv
source ../azureFunctionsEnv/bin/activate && sleep 1
# Install packages
pip3 install --upgrade pip
pip3 install -r requirements.txt
cd ../azureFunctionsEnv
# Move the Function folder into the environment root folder
mv ../PythonAZFunctionVMOperator .
# Print an installation message
echo "Environment 'azureFunctionsEnv' was created and PythonAZFunctionVMOperator function was installed. Make sure to add the appropriate credentials to the .env file."
