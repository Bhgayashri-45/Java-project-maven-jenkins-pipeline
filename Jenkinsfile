pipeline {
    agent any

    tools {
        maven 'Maven 3.9.0' // Name must match Maven installation in Jenkins
        jdk 'JDK 17'         // Name must match JDK in Jenkins (optional if JAVA_HOME is set)
    }

    environment {
        SONARQUBE_ENV = 'SonarQubeServer' // Name as configured in Jenkins Sonar settings
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://your-repo-url.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Code Quality - SonarQube') {
            steps {
                withSonarQubeEnv("${SONARQUBE_ENV}") {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=java-pipeline -Dsonar.projectName=Java Pipeline Project'
                }
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }
    }
}
