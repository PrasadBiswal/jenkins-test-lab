pipeline {
    // 'agent any' tells Jenkins to run this on your WSL Ubuntu node
    agent any

    // Environment variables make your pipeline "Reusable" (Don't hardcode names!)
    environment {
        APP_NAME = "enterprise-dotnet-app"
        IMAGE_TAG = "v${env.BUILD_ID}" // Automatically versions each build (v1, v2, v3...)
    }

    stages {
        stage('Step 1: Checkout') {
            steps {
                echo "--- PULLING CODE FROM GITHUB ---"
                checkout scm
            }
        }

        stage('Step 2: Security & Env Check') {
            steps {
                echo "--- VERIFYING INFRASTRUCTURE ---"
                // SRE Task: Ensure Docker is alive before trying to build
                sh 'docker version'
                sh 'dotnet --version || echo "Dotnet not installed on host, using Docker instead."'
            }
        }

        stage('Step 3: Docker Build') {
            steps {
                echo "--- BUILDING CONTAINER: ${APP_NAME}:${IMAGE_TAG} ---"
                /* 'docker build' uses your Dockerfile to package the .NET app.
                   We tag it with the Build ID so we can track exactly which 
                   version of the code created this image.
                */
                sh "docker build -t ${APP_NAME}:${IMAGE_TAG} ."
                sh "docker tag ${APP_NAME}:${IMAGE_TAG} ${APP_NAME}:latest"
            }
        }

        stage('Step 4: Automated Testing') {
            steps {
                echo "--- RUNNING SMOKE TESTS ---"
                /* We run the container to see if it actually works.
                   '--rm' ensures we don't leave "ghost" containers eating RAM.
                */
                sh "docker run --rm ${APP_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Step 5: Cleanup') {
            steps {
                echo "--- REMOVING OLD BUILD LAYERS ---"
                // SRE Task: Keep the disk clean so your PC doesn't slow down
                sh "docker image prune -f"
            }
        }
    }

    // Post-actions run even if the build fails
    post {
        always {
            echo "Pipeline finished. Check 'Console Output' for details."
        }
        failure {
            echo "ALARM: Build Failed! Check the Dockerfile syntax."
        }
    }
}