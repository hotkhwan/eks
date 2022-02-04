pipeline {
    agent {
        kubernetes {
        inheritFrom  "jenkins"
        }
    }
    environment {
        registry = "https://378537635200.dkr.ecr.ap-southeast-1.amazonaws.com"
        aws_access_key_id = "AKIAVQIUZ5WAEGCJ53VJ"
        aws_secret_access_key = "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"
        AWS_ACCOUNT_ID = "378537635200"
        AWS_DEFAULT_REGION = "ap-southeast-1"
        IMAGE_REPO_NAME = "eks"
        IMAGE_TAG = "latest"
        REPOSITORY_URI = "https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }

    stages {
        stage('Prepare Stage') {
            parallel {
                stage('this runs in a pod') {
                    steps {
                        // container('jenkins-docker-client') {
                        // sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'  
                        // sh 'chmod u+x ./kubectl'  
                        // sh 'uptime'
                        // sh 'curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator'
                        // sh 'chmod +x ./aws-iam-authenticator'
                        // sh './aws-iam-authenticator help'
                        // sh 'curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"'
                        // sh 'unzip awscliv2.zip'
                        // sh './aws/install'
                        // sh 'aws --version'
                        // sh 'aws sts get-caller-identity'
                        // sh "aws configure set aws_access_key_id ${aws_access_key_id}; aws configure set aws_secret_access_key ${aws_secret_access_key}; aws configure set default.region ${AWS_DEFAULT_REGION}; aws configure set output 'json'"
                        // sh 'aws sts get-caller-identity'
                        // withKubeConfig([credentialsId: 'eks']) {
                            sh 'kubectl get pods'
                            // }   
                        }
                    }
                }
            }
        // }

        stage('Docker Build and Push image in to AWS') {
            steps {
                script {
                    dir("eks") {
                        sh "ls -la ${pwd()}"
                        sh "docker version"
                        docker.withRegistry(
                            "${REPOSITORY_URI}", 
                            "ecr:${AWS_DEFAULT_REGION}:aws") { 
                            def eksImage = docker.build("${IMAGE_REPO_NAME}")
                            eksImage.push("${IMAGE_TAG}")
                            echo "Build Image Success"
                        } 
                    }
                }
            }
        }

        // stage('Deployment') {
        //     steps {
        //         // container('python') {
        //         sh './kubectl apply -f deployment.yml'
        //         // }
        //     }
        // }
        stage('Deployment') {
            steps {
                sh "ls -la ${pwd()}"
                withKubeConfig([credentialsId: 'eks']) {
                    // sh './kubectl get pods'
                    sh './kubectl apply -f deployment.yml'
                }
            }
        }
    }
    
}

// pipeline {
//     agent none
//     stages {
//         stage('Back-end') {
//             agent {
//                 docker { image 'maven:3.8.1-adoptopenjdk-11' }
//             }
//             steps {
//                 sh 'mvn --version'
//             }
//         }
//         stage('Front-end') {
//             agent {
//                 docker { image 'node:16.13.1-alpine' }
//             }
//             steps {
//                 sh 'node --version'
//             }
//         }
//     }
// }