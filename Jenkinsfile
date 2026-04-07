pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Pulling latest code from GitHub...'
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building the .NET Container Image...'
                // This command looks for the "Dockerfile" in your folder
                sh 'docker build -t enterprise-app:v1 .'
            }
        }

        stage('Verify & Clean') {
            steps {
                echo 'Verifying the new image exists...'
                sh 'docker images | grep enterprise-app'
                echo 'Success! Image is ready for deployment.'
            }
        }
    }
}