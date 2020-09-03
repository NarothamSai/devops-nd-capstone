pipeline {
     agent any
     stages {
         stage('Print Building') {
              steps {
                  sh 'echo Building...'
              }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
                  sh 'hadolint Dockerfile'
              }
         }
         stage('Build Docker Image') {
              steps {
                  sh 'docker build -t nginx-web-server:0.0.3 .'
              }
         }
         stage('Push Docker Image') {
              steps {
                  withDockerRegistry([url: "", credentialsId: "docker-id"]) {
                      sh upload_docker.sh
                  }
              }
         }
        stage("Cleaning up") {
              steps{
                    echo 'Cleaning up...'
                    sh "docker system prune"
              }
        }
     }
}