pipeline {
    agent any

    environment {
        FLUTTER_HOME = "${env.WORKSPACE}/flutter"
        PATH = "${env.PATH}:${FLUTTER_HOME}/bin"
    }

    stages {
        stage('Setup Flutter') {
            steps {
                script {
                    // Check if Flutter is already installed
                    if (!fileExists("${FLUTTER_HOME}/bin/flutter")) {
                        sh 'git clone -b stable https://github.com/flutter/flutter.git "${FLUTTER_HOME}"'
                        sh '${FLUTTER_HOME}/bin/flutter doctor'
                    } else {
                        echo "Flutter is already installed"
                    }
                }
            }
        }

        stage('Dependencies') {
            steps {
                sh 'flutter pub get'
            }
        }

        stage('Build APK') {
            steps {
                sh 'flutter build apk --release'
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
