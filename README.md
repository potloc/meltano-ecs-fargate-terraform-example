### Overview
This repository is an example of our meltano infrastructure in production. Hopefully it allows others to easily put their own meltano project into production.

### Main components
Here is the TLDR for the repository:
- Hosted in AWS Fargate (didn't want to manage VMs)
- Managed as infrastructure-as-code using terraform
- Include 3 docker containers:
    - Airflow scheduler
    - Meltano UI
    - Airflow webserver
- To integrate persistence into our state, we tried to integrate [EFS](https://aws.amazon.com/efs/) but this did not work, so we just used 2 [RDS](https://aws.amazon.com/rds/) integrations instead
