pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }

    environment {
        DOCKER_IMAGE = "kirilkirilov96/ci-cd-web-app"
        // Update the path below to your actual kubeconfig file location
        KUBECONFIG = "C:\\Users\\pearo\\.kube\\config"
    }

    stages {
        stage('Checkout Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/KirilKirilov966/ci-cd-web-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: '12c17ac0-0afb-448e-ac76-363fe1cfba0f', url: 'https://index.docker.io/v1/']) {
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
