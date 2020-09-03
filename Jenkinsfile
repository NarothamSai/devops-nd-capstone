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
         stage('Push Docker Image To Docker Hub') {
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
         stage('Deploying') {
              steps{
                  echo 'Deploying to AWS...'
                  withAWS(credentials: 'aws-id', region: 'ap-south-1') {
                      sh "aws eks --region ap-south-1 update-kubeconfig --name nginx-web-server"
                      sh "kubectl config use-context arn:aws:eks:ap-south-1:177633364078:cluster/nginx-web-server"
                      sh "kubectl apply -f config-kub.yml"
                      sh "kubectl rollout status deployments/nginx-web-server"
                      sh "kubectl get nodes"
                      sh "kubectl get deployment"
                      sh "kubectl get pod -o wide"
                      sh "kubectl get service/nginx-web-server"
                  }
              }
        }
        stage('Status EKS Deployment') {
              steps{
                  echo 'Deploying to AWS...'
                  withAWS(credentials: 'aws-id', region: 'ap-south-1') {
                      sh "kubectl rollout status deployments/nginx-web-server"
                  }
              }
        }
        stage('Cleaning') {
              steps{
                    echo 'Cleaning up...'
                    sh "docker system prune -y"
              }
        }
     }
}