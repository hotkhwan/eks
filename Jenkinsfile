pipeline {
    agent any

    environment {
        registry = "https://378537635200.dkr.ecr.ap-southeast-1.amazonaws.com"
    }

    stages {
        stage('Docker Push image') {
            steps {
                script {
                    dir("eks") {
                         sh "ls -la ${pwd()}"
                        docker.withRegistry(
                        "https://378537635200.dkr.ecr.ap-southeast-1.amazonaws.com", 
                        "ecr:ap-southeast-1:aws") {
                        def eksImage = docker.build("eks")
                        eksImage.push('1.0.0')
                        }
                    }
                }
            }
        }
        // stage('Deployment') {
        //     steps {
        //         sh 'kubectl apply -f deployment.yml';
        //     }
        // }
    }
}