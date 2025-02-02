# GitHub Actions Workflows

[.github/workflows](https://github.com/iorikaze/startbootstrap-resume/tree/master/.github/workflows) contains automation workflows for the startbootstrap-resume project, powered by GitHub Actions. These workflows help automate tasks such as building, testing, and deploying the resume application.

## Workflows Overview

### 1. check-dependencies

Purpose: Automates checking and fixing of errors in the dependencies.

Triggers:

When [pull](https://github.com/iorikaze/startbootstrap-resume/blob/master/.github/workflows/pull.yaml) and [push-ecr](https://github.com/iorikaze/startbootstrap-resume/blob/master/.github/workflows/push-ecr.yaml) are run or triggered.

Actions Performed:

Installs necesarry dependencies.

Fixes any errors and vulnerabilties in the dependencies.


