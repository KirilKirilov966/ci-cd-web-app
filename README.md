# **CI/CD Pipeline for DevOps Portfolio** 🚀

This project is a **fully automated CI/CD pipeline** for deploying a web application using **Jenkins, Docker, Kubernetes, and GitHub**. It integrates **version control, automated builds, testing, and deployment** in a scalable environment.

---

##  Technologies Used
- **Jenkins** – CI/CD automation
- **Docker** – Containerization
- **Kubernetes** – Deployment & scaling
- **GitHub** – Version control
- **Vercel** – Hosting frontend
- **Slack & Email Alerts** – Build notifications
- **Prometheus & Grafana** – Monitoring pipeline

---

##  Step 1: Setting Up Jenkins
1️⃣ **Install Jenkins** on your system.
   ```bash
   sudo apt update && sudo apt install jenkins -y
   ```
2️⃣ **Install Required Jenkins Plugins:**
   - Pipeline
   - Docker Pipeline
   - Kubernetes CLI
   - Slack Notification Plugin
   - Prometheus Metrics Plugin

3️⃣ **Create a New Jenkins Pipeline Job**:
   - Go to **Jenkins Dashboard** → **New Item** → **Pipeline**
   - Select **Pipeline Script from SCM**
   - Enter your GitHub repo URL
   - Set **Branch Specifier** to `*/main`

---

##  Step 2: Configure GitHub Integration
1️⃣ **Verify Git is Installed**
   ```bash
   git --version
   ```
2️⃣ **Connect GitHub to Jenkins** (For private repositories, add credentials in Jenkins)
3️⃣ **Ensure Jenkins Can Clone Repo**
   ```bash
   git clone https://github.com/KirilKirilov966/ci-cd-web-app.git
   ```

---

##  Step 3: Set Up Docker & Image Versioning
1️⃣ **Install Docker**
   ```bash
   sudo apt install docker.io -y
   ```
2️⃣ **Log in to Docker Hub in Jenkins**
   ```bash
   docker login
   ```
3️⃣ **Modify `Jenkinsfile` to Use Versioned Tags**
   ```groovy
   script {
       def version = new Date().format("yyyyMMdd-HHmmss")
       env.IMAGE_TAG = "kirilkirilov96/ci-cd-web-app:${version}"
       sh "docker build -t ${IMAGE_TAG} ."
       sh "docker tag ${IMAGE_TAG} kirilkirilov96/ci-cd-web-app:latest"
   }
   ```
4️⃣ **Push Image to Docker Hub**
   ```bash
   docker push kirilkirilov96/ci-cd-web-app:latest
   ```

---

## ** Step 4: Deploying to Kubernetes**
1️⃣ **Set Up Kubernetes Cluster**
   ```bash
   kubectl create namespace devops
   ```
2️⃣ **Create Deployment YAML (`k8s-deployment.yaml`)**
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: ci-cd-web-app
   spec:
     replicas: 3
     selector:
       matchLabels:
         app: ci-cd-web-app
     template:
       metadata:
         labels:
           app: ci-cd-web-app
       spec:
         containers:
           - name: web-app
             image: kirilkirilov96/ci-cd-web-app:latest
             ports:
               - containerPort: 4000
   ```
3️⃣ **Apply Deployment**
   ```bash
   kubectl apply -f k8s-deployment.yaml
   ```

---

## ** Step 5: Setting Up CI/CD Pipeline in Jenkins**
1️⃣ **Modify `Jenkinsfile` to Include All Stages**
   ```groovy
   pipeline {
       agent any

       environment {
           DOCKER_IMAGE = "kirilkirilov96/ci-cd-web-app"
       }

       stages {
           stage('Clone Repository') {
               steps {
                   git branch: 'main', url: 'https://github.com/KirilKirilov966/ci-cd-web-app.git'
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
                   withDockerRegistry([credentialsId: 'docker-hub-credentials', url: 'https://index.docker.io/v1/']) {
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
   ```
2️⃣ **Run the Pipeline and Verify Deployment**

---

## ** Step 6: Adding Slack & Email Notifications**
1️⃣ **Install Slack Plugin in Jenkins**
2️⃣ **Set Up Slack Webhook in Jenkins > Configure System**
3️⃣ **Modify `Jenkinsfile` for Notifications**
   ```groovy
   post {
       success {
           slackSend channel: '#devops', message: "✅ Build SUCCESS for ${env.JOB_NAME} - ${env.BUILD_NUMBER}"
       }
       failure {
           slackSend channel: '#devops', message: "❌ Build FAILED for ${env.JOB_NAME} - ${env.BUILD_NUMBER}"
       }
   }
   ```

---

## ** Step 7: Monitoring Jenkins with Prometheus & Grafana**
1️⃣ **Install Prometheus Plugin in Jenkins**
2️⃣ **Run Prometheus in Docker**
   ```bash
   docker run -d -p 9090:9090 --name=prometheus prom/prometheus
   ```
3️⃣ **Run Grafana in Docker**
   ```bash
   docker run -d -p 3000:3000 --name=grafana grafana/grafana
   ```
4️⃣ **Import Jenkins Dashboard in Grafana**

---

## ** Conclusion**
This project successfully implements a **complete CI/CD pipeline** for a **DevOps portfolio**, integrating GitHub, Jenkins, Docker, Kubernetes, and monitoring tools.

🔹 **Automated builds & deployments** 🔹 **Secure credential storage** 🔹 **Live monitoring & notifications**
