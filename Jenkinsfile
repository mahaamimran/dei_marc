pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Setup Flutter') {
            steps {
                script {
                    // Clone Flutter SDK
                    sh 'git clone -b stable https://github.com/flutter/flutter.git "/var/jenkins_home/workspace/Build APK Flutter/flutter"'
                    // Run Flutter Doctor to verify installation
                    sh '"/var/jenkins_home/workspace/Build APK Flutter/flutter/bin/flutter" doctor'
                }
            }
        }
        
        stage('Dependencies') {
            steps {
                sh '"/var/jenkins_home/workspace/Build APK Flutter/flutter/bin/flutter" pub get'
            }
        }
        
        stage('Build APK') {
            steps {
                sh '"/var/jenkins_home/workspace/Build APK Flutter/flutter/bin/flutter" build apk --release'
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up...'
            cleanWs()
        }
    }
}
