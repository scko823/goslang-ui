pipeline {
    agent any

    stages {
        stage ('Build Info') {
            steps {
                sh "echo BUILD_URL: ${env.BUILD_URL}"
                sh "echo ${env.JOB_NAME} #${env.BUILD_NUMBER}"
                sh "echo ================ Git ================="
                sh "git rev-parse HEAD | cut -c1-6"
            }
        }
        stage ('Install') {
            steps {
                sh 'npm install'
            }
        }
        stage ('Test') {
            steps {
                sh 'npm test'
            }
        }
        stage ('Build') {
            steps {
                sh 'npm run build'
            }
            post {
                success {
                    sh 'zip -r assets.zip assets/'
                }
            }
        }
        stage ('Downstream') {
            steps {
                build job: 'goslang-backend pipeline', wait: false, parameters: [[$class: 'FileParameterValue', name: 'target', value: 'assets.zip']]
            }
        }
    }
}