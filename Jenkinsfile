pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Pulling code from GitHub...'
                checkout scm
            }
        }

        stage('Environment Check') {
            steps {
                echo 'Checking System Info...'
                sh 'whoami'
                sh 'curl --version'
            }
        }

        stage('Docker Validation') {
            steps {
                echo 'Verifying Docker Engine is running...'
                sh 'docker --version'
                sh 'docker ps'
            }
        }
        
        stage('Build Simulation') {
            steps {
                echo 'Preparing to build .NET Application Image...'
                // This is where we will eventually put "docker build"
                sh 'echo "Ready for next step: Dockerfile creation"'
            }
        }
    }
}