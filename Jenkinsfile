pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'your_dockerhub_username'  // Replace with your Docker Hub username
        IMAGE_NAME = 'nodejs-ci-cd-demo'
        TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git(
                    url: 'https://github.com/shubham982194/nodejs-ci-cd-demo.git',
                    credentialsId: 'github-pat'
                )
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKERHUB_USER/$IMAGE_NAME:$TAG .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker push $DOCKERHUB_USER/$IMAGE_NAME:$TAG'
                }
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker stop nodejs-ci-cd-demo || true'
                sh 'docker rm nodejs-ci-cd-demo || true'
                sh 'docker run -d --name nodejs-ci-cd-demo -p 3000:3000 $DOCKERHUB_USER/$IMAGE_NAME:$TAG'
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful!"
            emailext (
                to: 'you@example.com',  // Replace with your email
                subject: "Build Success: ${currentBuild.fullDisplayName}",
                body: "Good news! The build succeeded."
            )
        }
        failure {
            echo "❌ Build failed!"
            emailext (
                to: 'you@example.com',  // Replace with your email
                subject: "Build Failed: ${currentBuild.fullDisplayName}",
                body: "Oops! Something went wrong."
            )
        }
    }
}
