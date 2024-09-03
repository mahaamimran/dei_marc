pipeline {
    agent any

    tools {
        // Install the Flutter SDK
        flutter 'flutter-sdk'
    }

    environment {
        // Define environment variables
        ANDROID_HOME = "${env.HOME}/Android/Sdk"
        PATH = "$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin"
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Install Flutter dependencies
                    sh 'flutter pub get'
                }
            }
        }

        stage('Build APK') {
            steps {
                script {
                    // Build the APK
                    sh 'flutter build apk --release'
                }
            }
        }

        stage('Archive APK') {
            steps {
                // Archive the APK file to Jenkins artifacts
                archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', allowEmptyArchive: true
            }
        }

        stage('Clean Up') {
            steps {
                // Clean up the workspace after the build
                cleanWs()
            }
        }
    }

    post {
        success {
            echo 'APK build successful!'
        }
        failure {
            echo 'APK build failed.'
        }
    }
}
