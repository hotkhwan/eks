pipeline {
    agent any

    environment {
        dockerImage = ''
    }

    stages {
        stage('Build') {
            steps {
                dir("example") {
                    sh "pwd"
                    sh "ls -la ${pwd()}"
                    sh 'mvn -B -DskipTests clean package'
                }
            }
        }
        stage('Test') {
            steps {
                dir("example") {
                    sh "pwd"
                    sh "ls -la ${pwd()}"
                    sh 'mvn test'
                }

            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        // stage('Build image') {
        //     steps {
        //         script {
        //             dockerImage = docker.build("phayao/my-app")
        //         }
        //     }
        // }
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