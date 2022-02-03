pipeline {
    agent {
        kubernetes {
        yamlFile 'build-agent.yaml'
        defaultContainer 'jenkins-docker-client'
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
                    container('jenkins-docker-client') {
                    sh 'uptime'
                    }
                }
                }

                stage('Docker Build and Push image in to AWS') {
                    steps {
                        script {
                            dir("eks") {
                                sh "ls -la ${pwd()}"
                                sh "docker version"
                                sh "$REPOSITORY_URI"
                                // docker.withRegistry(
                                //     "${REPOSITORY_URI}", 
                                //     "ecr:${AWS_DEFAULT_REGION}:aws") {
                                //     echo "Login success"  
                                //     def eksImage = docker.build("${IMAGE_REPO_NAME}")
                                //     echo eksImage
                                //     eksImage.push("${IMAGE_TAG}")
                                //     echo "Build Image Success"
                                docker.withRegistry('https://378537635200.dkr.ecr.ap-southeast-1.amazonaws.com/eks', 'ecr.ap-southeast-1.aws') {

                                def customImage = docker.build("my-image:latest")

                                /* Push the container to the custom Registry */
                                customImage.push()
                                } 
                            }
                        }
                    }
                }

            }
        }
        // stage('Docker Push image') {
        //     steps {
        //         script {
        //             dir("eks") {
        //                  sh "ls -la ${pwd()}"
        //                  docker.withTool("default") { 
        //                     sh "docker version"
        //                     docker.withRegistry("${REPOSITORY_URI}", "ecr:${AWS_DEFAULT_REGION}:aws") {
        //                         echo "Login success"  
        //                         def eksImage = docker.build("${IMAGE_REPO_NAME}")
        //                         echo eksImage
        //                         eksImage.push("${IMAGE_TAG}")
        //                         echo "Build Image Success"
        //                     }
        //                 }   
        //             }
        //         }
        //     }
        // }
        stage('Deployment') {
            steps {
                sh "ls -la ${pwd()}"
                withKubeConfig([credentialsId: 'kubernetes-config']) {
                    sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'  
                    sh 'chmod u+x ./kubectl'  
                    sh './kubectl get pods'
                    sh './kubectl apply -f deployment.yml'
                }
            }
        }
    }
}