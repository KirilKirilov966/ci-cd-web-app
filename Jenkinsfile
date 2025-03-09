pipeline {
    agent any

    // Prevent default SCM checkout to avoid conflicts
    options {
        skipDefaultCheckout(true)
    }

    environment {
        DOCKER_IMAGE = "kirilkirilov96/ci-cd-web-app"
    }

    stages {
        stage('Checkout Repository') {
            steps {
                // Explicitly check out the main branch
                git branch: 'main', url: 'https://github.com/KirilKirilov966/ci-cd-web-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Use bat instead of sh for Windows
                bat "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: 'https://index.docker.io/v1/']) {
                    bat "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                bat "kubectl apply -f k8s-deployment.yaml"
            }
        }
    }
}
