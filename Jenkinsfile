pipeline {
    agent any

    tools {
        jdk 'Java17'
        maven 'Maven3'
    }

    environment {
        DOCKER_USER = "kittappaprathapa"
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

        stage('Docker Build & Push') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
                sh 'docker push ${IMAGE_NAME}:${IMAGE_TAG}'
            }
        }

        stage('Security Scan - Trivy') {
            steps {
                // Run Trivy scan on the pushed image
                sh 'trivy image ${IMAGE_NAME}:${IMAGE_TAG} || true'
            }
        }
    }
}

