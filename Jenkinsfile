pipeline{
    agent any
    tools {
        maven 'maven'
    }
    stages{
        stage("Checkout"){
            steps{
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'github_access', url: 'https://github.com/SNazeer786/Payment-Resource-project.git']])
            }    
        }
        stage("Build"){
            steps{
                sh 'mvn clean install'
            }
        }
        stage("Build Docker Image"){
            steps{
                script{
                    sh 'docker build -t payment-image .'
                    sh 'docker tag payment-image nazeer78/payment-image:latest'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                   sh 'docker login -u nazeer78 -p ${dockerhubpwd}'

}
                   sh 'docker image push nazeer78/payment-image:latest'
                }
            }
        }
        stage('Deploy to k8s'){
            steps{
                script{
                    kubernetesDeploy (configs: 'deploymentservice.yaml',kubeconfigId: 'k8sconfigpwd')
                }
            }
        }

