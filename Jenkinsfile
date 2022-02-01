pipeline {
    agent any

    environment {
        dockerImage = ''
    }

    stages {
        stage('Docker Push image') {
            steps {
                script {
                    docker.withRegistry(
                        "https://378537635200.dkr.ecr.ap-southeast-1.amazonaws.com", 
                        "ecr:ap-southeast-1:ecr-id") {
                        def eksImage = docker.build("eks")
                        eksImage.push('1.0.0')
                    }
                }
            }
        }
        stage('Deployment') {
            steps {
                sh 'kubectl apply -f deployment.yml';
            }
        }
    }
}