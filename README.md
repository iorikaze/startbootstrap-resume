# GitHub Actions Workflows

[.github/workflows](https://github.com/iorikaze/startbootstrap-resume/tree/master/.github/workflows) contains automation workflows for the startbootstrap-resume project, powered by GitHub Actions. These workflows help automate tasks such as building, testing, and deploying the resume application.

## Workflows Overview

### 1. check-dependencies

Purpose: Automates checking and fixing of vulnerabilties in the dependencies.

Triggers:
When [pull](https://github.com/iorikaze/startbootstrap-resume/blob/master/.github/workflows/pull.yaml) and [push-ecr](https://github.com/iorikaze/startbootstrap-resume/blob/master/.github/workflows/push-ecr.yaml) are run or triggered.

Actions Performed:
- Installs necesarry dependencies.
- Fixes any vulnerabilties in the dependencies.

### 2. check-test-cases

Purpose: Cross check with test cases using JEST.

Triggers:
When [push-ecr](https://github.com/iorikaze/startbootstrap-resume/blob/master/.github/workflows/push-ecr.yaml) is triggered.

Actions Performed:
- Runs and cross checks the code with the test cases.

### 3. pull

Purpose: Whenever a pull request is done, it will check the dependencies.

Triggers:
Whenever a pull request is done.

Actions Performed:
- It will trigger [check-dependencies](https://github.com/iorikaze/startbootstrap-resume/blob/master/.github/workflows/check-dependencies.yaml) to check for dependencies vulnerabilities.

### 4. push-ecr

Purpose: To build, tag, and push a docker image to AWS ECR.

Triggers:
A manual trigger by the user that also includes a user input for the tag of the image.

Actions Performed:
- It will trigger [check-dependencies](https://github.com/iorikaze/startbootstrap-resume/blob/master/.github/workflows/check-dependencies.yaml) to check for dependencies vulnerabilities.
- It will trigger [check-test-cases](https://github.com/iorikaze/startbootstrap-resume/blob/master/.github/workflows/check-test-cases.yaml) to cross check with the test cases using JEST.
- It will build the image and push it AWS ECR.

### 5. deploy-ec2

Purpose: To pull and run/deploy the ECR image to an EC2.

Triggers:
A manual trigger by the user that also includes a user input for the tag of the image.

Actions Performed:
- It will pull and run the docker image in ECR then deploy it to the EC2.


