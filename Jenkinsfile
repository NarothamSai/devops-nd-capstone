pipeline {
     agent any
     stages {
         stage('Build') {
              steps {
                  sh 'echo Building...'
              }
         }
         stage('Lint HTML') {
              steps {
                  sh '''
                    cd html
                    ls
                    tidy -q -e *.html
                  '''
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
        stage('Cleaning') {
              steps{
                    echo 'Cleaning up...'
                    sh "docker system prune"
              }
        }
     }
}