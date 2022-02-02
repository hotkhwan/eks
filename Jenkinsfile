pipeline {
    agent any

    // tools {
    //     // a bit ugly because there is no `@Symbol` annotation for the DockerTool
    //     // see the discussion about this in PR 77 and PR 52: 
    //     // https://github.com/jenkinsci/docker-commons-plugin/pull/77#discussion_r280910822
    //     // https://github.com/jenkinsci/docker-commons-plugin/pull/52
    //     'org.jenkinsci.plugins.docker.commons.tools.DockerTool' 'default'
    // }

    environment {
        registry = "https://378537635200.dkr.ecr.ap-southeast-1.amazonaws.com"
        AWS_ACCOUNT_ID = "378537635200"
        AWS_DEFAULT_REGION = "ap-southeast-1"
        IMAGE_REPO_NAME = "eck"
        IMAGE_TAG = "latest"
        REPOSITORY_URI = "https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }

    stages {
        //  stage('Logging into AWS ECR') {
        //     steps {
        //         script {
        //         sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
        //         }
                 
        //     }
        // }
    //     // Building Docker images
        // stage('Building image') {
        //     steps{
        //         script {
        //             dir("eks") {
        //                 sh "ls -la ${pwd()}"
        //                 dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        //             }
        //         }
        //     }
        // }
        stage('Docker Push image') {
            steps {
                script {
                    dir("eks") {
                        sh "ls -la ${pwd()}"
                        sh "docker version"
                        docker.withRegistry("${REPOSITORY_URI}", "ecr:${AWS_DEFAULT_REGION}:aws") {
                            echo "Login success"  
                            def eksImage = docker.build("${IMAGE_REPO_NAME}")
                            echo eksImage
                            eksImage.push("${IMAGE_TAG}")
                            echo "Build Image Success"
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
        // stage('Deployment') {
        //     steps {
        //         sh "ls -la ${pwd()}"
        //         withKubeConfig([credentialsId: 'kubernetes-config']) {
        //             sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'  
        //             sh 'chmod u+x ./kubectl'  
        //             sh './kubectl get pods'
        //             sh './kubectl apply -f deployment.yml'
        //         }
        //     }
        // }
    }
}