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
                    cd ..
                  '''
              }
         }
         stage('Build Docker Image') {
              steps {
                  sh 'ls'
                  sh 'docker build -t nginx-web-server:0.0.3 .'
              }
         }
         stage('Push Docker Image') {
              steps {
                  withDockerRegistry([url: "", credentialsId: "docker-id"]) {
                      sh '''
                        dockerpath=narothamsai/nginx-web-server:0.0.3
                        docker tag nginx-web-server:0.0.3 $dockerpath
                        docker push $dockerpath
                      '''
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