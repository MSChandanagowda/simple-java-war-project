pipeline {
    agent any

    tools {
        jdk 'Java17'
        maven 'Maven3'
    }

    environment {
        DOCKER_USER = "chandana2203"
        IMAGE_NAME = "${DOCKER_USER}/myapp"
        IMAGE_TAG = "v1.0.0"
    }

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('My SonarQube Server') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
                }

                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub', // <-- Jenkins credentials ID
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD'
                )]) {
                    sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                    sh 'docker push ${IMAGE_NAME}:${IMAGE_TAG}'
                }
            }
        }

        stage('Security Scan - Trivy') {
            steps {
                sh 'trivy image ${IMAGE_NAME}:${IMAGE_TAG} || true'
            }
        }
    }
}
