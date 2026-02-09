# de-tools-gcp-bigquery

The answer of the exercise can be found in 

    BigQuery-Answers.sql
    
The gcp bucket `afarmijostech_dezoomcamp_hw3_2025` and bigquery `rides_dataset` dataset were created through terraform, with these commands

    export GOOGLE_APPLICATION_CREDENTIALS="PATH OF JSON FILE"
    terraform init
    terraform plan -var-file=demo.tfvars
    terraform apply -var-file=demo.tfvars


