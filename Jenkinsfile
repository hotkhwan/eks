pipeline {
    agent {
        kubernetes {
        yamlFile 'build-agent.yaml'
        defaultContainer 'default'
        idleMinutes 1
        }
    }
    environment {
        registry = "https://378537635200.dkr.ecr.ap-southeast-1.amazonaws.com"
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
                    container('default') {
                    sh 'uptime'
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
        //     agent { 
        //         kubernetes {
        //         yamlFile 'deployment.yaml'
        //         defaultContainer 'python'
        //         idleMinutes 1
        //         }
        //     }
        //     parallel {
        //         stage('this runs in a Production') {
        //             steps {
        //                 container('python') {
        //                 sh 'uptime'
        //                 }
        //             }
        //         }
        //     }
        // }
        stage('Deployment') {
            steps {
                sh "ls -la ${pwd()}"
                withKubeConfig([credentialsId: 'EKS']) {
                    sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'  
                    sh 'chmod u+x ./kubectl'  
                    sh './kubectl get pods'
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