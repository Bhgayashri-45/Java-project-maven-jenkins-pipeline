pipeline {
    agent any

    tools {
        jdk 'jdk17'
        maven 'Maven_3.8.7'
    }

    environment {
        DOCKER_IMAGE = 'bhagyashri45/java-test-app'
        DOCKER_TAG = '1.0'
        DOCKER_CREDENTIALS_ID = 'docker-hub-creds'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Bhgayashri-45/Java-project-maven-jenkins-pipeline.git'
            }
        }

        stage('Image Build and push') {
            steps {
                script{
                    sh '''
                        echo "Building Docker Image ..."
                        docker build -t $DOCKER_IMAGE:$DOCKER_TAG .
                    '''
                    withCredentials([usernamePassword(credentialId: "$DOCKER_CREDENTIALS_ID", usernameVariable: "DOCKER_IMAGE", passwordVariable: "DOCKER_PASS")]){
                        sh '''
                            echo "Docker logging in ..."
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            echo "Docker image push ..."
                            docker push $DOCKER_USER:$DOCKER_TAG
                        '''
                    }

                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withCredentials([string(credentialsId: 'Jenkins-Sonarqube-Token', variable: 'SONAR_TOKEN')]) {
                    sh """
                        mvn clean verify sonar:sonar \
                          -Dsonar.projectKey=Java-project-maven-jenkins-pipeline \
                          -Dsonar.projectName=Java-project-maven-jenkins-pipeline \
                          -Dsonar.java.binaries=. \
                          -Dsonar.host.url=http://localhost:9000 \
                          -X
                    """
                }
            }
        }

    }

    post {
            success {
                echo "✅ Successfully built and pushed Docker image to Docker Hub!"
            }
            failure {
                echo "❌ Pipeline failed. Check logs for more details."
            }
        }
}
