pipeline {
    agent any

    environment {
        registry = "https://378537635200.dkr.ecr.ap-southeast-1.amazonaws.com"
        AWS_ACCOUNT_ID = "378537635200"
        AWS_DEFAULT_REGION = "ap-southeast-1"
        IMAGE_REPO_NAME = "eck"
        IMAGE_TAG = "latest"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
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
                        docker.withRegistry(
                        "${REPOSITORY_URI}", 
                        "ecr:${AWS_DEFAULT_REGION}:aws") {
                        def eksImage = docker.build("${IMAGE_REPO_NAME}")
                        eksImage.push("${IMAGE_TAG}")
                        }
                    }
                }
            }
        }
        stage('Deployment') {
            steps {
                sh "ls -la ${pwd()}"
                sh "kubectl apply -f deployment.yml";
            }
        }
    }
}