# GitHub Actions Workflows

[.github/workflows](https://github.com/iorikaze/startbootstrap-resume/tree/master/.github/workflows) contains automation workflows for the startbootstrap-resume project, powered by GitHub Actions. These workflows help automate tasks such as building, testing, and deploying the resume application.

## Pre-requisites

### 1. IAM Role
- This should include ECR Power User permission
- This should have [Trust Policy for GitHub Actions](https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/)

### 2. EC2
- This should have public IP
- The Security Group should be open to port 443, SSH, 80, and 3000.

### 2. Installations on local machine
- [Docker](https://docs.docker.com/desktop/setup/install/windows-install/)
- [Nodejs](https://nodejs.org/en/download)
- [Jest](https://jestjs.io/docs/getting-started)

## Dockerfile
![image](https://github.com/user-attachments/assets/992027bd-6381-45dd-83ea-e8d80cf6a708)
- Used alpine version of nodejs base image
- Used an existing user and transferred ownership of the directories
- Created a port mapping to port 3000
- Implemented a health check that runs every 30 seconds and ensures that the application responds within 10 seconds. If the check fails 3 times consecutively, the container is marked as unhealthy.
- Executes the command npm run start

## Workflows Overview
![CICD](https://github.com/user-attachments/assets/64dde08d-48e3-4715-ac00-a98b89932132)

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

Expected Outputs:
![image](https://github.com/user-attachments/assets/3bdf71d5-7784-4c12-bd52-b481e7302071)
![image](https://github.com/user-attachments/assets/fae08b4f-03c2-4478-8717-52d6aefa40ce)

### 4. push-ecr

Purpose: To build, tag, and push a docker image to AWS ECR.

Triggers:
A manual trigger by the user that also includes a user input for the tag of the image.

Actions Performed:
- It will trigger [check-dependencies](https://github.com/iorikaze/startbootstrap-resume/blob/master/.github/workflows/check-dependencies.yaml) to check for dependencies vulnerabilities.
- It will trigger [check-test-cases](https://github.com/iorikaze/startbootstrap-resume/blob/master/.github/workflows/check-test-cases.yaml) to cross check with the test cases using JEST.
- It will build the image and push it AWS ECR.

Expected Outputs:
![image](https://github.com/user-attachments/assets/3e79ae91-f162-4480-a030-7a34a46e26dc)
![image](https://github.com/user-attachments/assets/8ea8e3ee-c06d-45b1-9e54-75519d18e580)
- Image and corresponding tag should reflect on AWS ECR and Docker Windows.


### 5. deploy-ec2

Purpose: To pull and run/deploy the ECR image to an EC2.

Triggers:
A manual trigger by the user that also includes a user input for the tag of the image.

Actions Performed:
- It will pull and run the docker image in ECR then deploy it to the EC2.

Expected Outputs:
![image](https://github.com/user-attachments/assets/41dbf4f5-98bd-43e5-bafc-f77fb0556ae2)
![image](https://github.com/user-attachments/assets/1975b2c1-5940-4353-9141-54bdfad52d44)
- Container should reflect in your Docker Windows and when you SSH into EC2 and run docker ps.

## Expected Application Output

Actions to Perform
1. SSH into the EC2
2. Run **docker ps**
3. Take the Public IP of the EC2 and append ":3000".
4. Run in a browser.

Expected Output:
![image](https://github.com/user-attachments/assets/4c796489-67f1-43c9-aaf3-cd01ad82acf3)
![image](https://github.com/user-attachments/assets/51924645-44c2-41bc-9e91-2ae6f330212c)

## Points to Improve on:
- Security of the Application. Deploy to a Fargate. If still using EC2, put it behind an ALB and WAF. Include an SSL certificate on the listenr. Make the application only accessible via HTTPS. Enable also GuardDuty
- Implement least privelege for Security Group of EC2.
- Use a EIP for static Public IP of EC2.
- Implement a cache to optimize performance of the pipeline.
- Implement better unit test cases.

## How to Modify Workflows
- All workflows are defined in YAML files inside .github/workflows/.
- To edit a workflow, modify the respective YAML file and commit the changes

## Troubleshooting
- Check the Actions tab in GitHub to view workflow logs.
- If a workflow fails, review the error messages and update the YAML accordingly.
- Ensure that all required secrets and environment variables are properly set.
- Can simulate commands by SSH into EC2

## Contributing
- If you want to add or improve workflows, create a feature branch and submit a pull request.
- Follow best practices for GitHub Actions and YAML syntax.

## License
This project follows the same license as the startbootstrap-resume repository. See the main repository for more details.
