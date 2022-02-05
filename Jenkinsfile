pipeline {
    agent {
        kubernetes {
        yamlFile 'build-agent.yaml'
        defaultContainer 'jenkins-agent'
        label 'jenkins'
        idleMinutes 1
        }
    }
    environment {
        registry = "https://378537635200.dkr.ecr.ap-southeast-1.amazonaws.com"
        aws_access_key_id = credentials("aws_user")
        aws_secret_access_key = credentials("aws_pass")
        AWS_ACCOUNT_ID = "378537635200"
        AWS_DEFAULT_REGION = "ap-southeast-1"
        IMAGE_REPO_NAME = "eks"
        // IMAGE_TAG = "latest"
        IMAGE_TAG = "1.0.0"
        REPOSITORY_URI = "https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }

    stages {
        stage('Prepare Stage') {
            parallel {
                stage('this runs in a pod to install kubectl command') {
                    steps {
                        container('jenkins-agent') {
                        sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.21.0/bin/linux/amd64/kubectl"'  
                        sh 'chmod u+x ./kubectl'  
                        sh './kubectl get pods'
                        sh './kubectl apply -f deployment.yaml'  
                        }
                    }
                }
            }
        }

        stage('Docker Build and Push image in to AWS') {
            steps {
                script {
                    dir("eks") {
                        sh "ls -la ${pwd()}"
                        sh "docker version"
                        sh "docker build --network=host . -t ${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                        docker.withRegistry(
                            "${REPOSITORY_URI}", 
                            "ecr:${AWS_DEFAULT_REGION}:aws") { 
                            sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                        } 
                        
                    }
                }
            }
        }


        stage('Deployment') {
            steps {
                sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.21.0/bin/linux/amd64/kubectl"'  
                sh 'chmod u+x ./kubectl'  
                sh "ls -la ${pwd()}"
                sh './kubectl get pods'
                sh './kubectl apply -f deployment.yaml'
                sh './kubectl get svc'
            }
        }
    }
    
}
