pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "kirilkirilov96/ci-cd-web-app"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/KirilKirilov966/ci-cd-web-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials']) {
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh "kubectl apply -f k8s-deployment.yaml"
            }
        }
    }
}
