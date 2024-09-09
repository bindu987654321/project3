pipeline {
    agent any

    environment {
        ARM_CLIENT_ID = credentials('ARM_CLIENT_ID')
        ARM_CLIENT_SECRET = credentials('ARM_CLIENT_SECRET')
        ARM_TENANT_ID = credentials('ARM_TENANT_ID')
        ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')

        TF_PLUGIN_SKIP_PROVIDER_REGISTRATION ='true'
    }
    stages {
       stage('Checkout') {
            steps {
                    git branch: 'main', url: 'https://github.com/pranavkumarpk01/TERRAFORM.git'
                 }
          }
        
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

      
        stage('Review Terraform Plan') {
            steps {
                script {
                    def planOutput = sh(script: 'terraform show -no-color tfplan', returnStdout: true).trim()
                    echo "Terraform Plan Output:"
                    echo planOutput
                    input message: "Review the plan before proceeding",
                          parameters: [text(name: 'Plan', description: 'Terraform plan', defaultValue: planOutput)]
                }
            }
        }

        stage('Apply Terraform Plan') {
            steps {
                script {
                    sh 'terraform apply tfplan'
                }
            }
        }

        stage('Destroy Infrastructure') {
            steps {
                script {
                    input message: "Are you sure you want to destroy the infrastructure?",
                          ok: "Destroy",
                          parameters: [choice(name: 'Confirmation', choices: 'Destroy')]
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
}
