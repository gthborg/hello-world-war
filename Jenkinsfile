pipeline{
   agent {
  label 'slave-machine'
}
    options {
  buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '5', numToKeepStr: '5')
}
   environment {
  dockerhub = "credentials('dockerhub')"
}
    tools {
        maven 'Maven'
    }
    stages{
        stage("Code Checkout"){
            steps{
                echo "========executing Code Checkout========"
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'mygitcreds', url: 'https://github.com/gthborg/hello-world-war.git']])
            }
            post{
                success{
                    echo "========Code Checkout completed========"
                }
                failure{
                    echo "========Code Checkout failed========"
                }
            }
        }
    
     stage("Execute Shell"){
            steps{
                echo "========execute Shell========"
                sh 'echo "HELLO world"'                
            }
            post{
                success{
                    echo "========Shell command completed========"
                }
                failure{
                    echo "========shell command failed========"
                }
            }
        }
    stage("Build application"){
            steps{
                echo "========Build========"
                sh 'mvn clean install'                
            }
            post{
                success{
                    echo "========Build completed========"
                }
                failure{
                    echo "========Build failed========"
                }
            }
        }
        stage("docker build"){
            steps{
                echo "====++++executing docker build++++===="
                sh "docker build -t helloworld:1.0.0 ."
            }
            post{
                always{
                    echo "====++++always++++===="
                }
                success{
                    echo "====++++docker build executed successfully++++===="
                }
                failure{
                    echo "====++++docker build execution failed++++===="
                }
        
            }
        }
        stage("docker push"){
            
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerhub_pwd', usernameVariable: 'dockerhub_user')]) {

                echo "====++++executing docker build++++===="
                //echo '$dockerhub_user'
                sh "echo $dockerhub_pwd | docker login -u $dockerhub_user --password-stdin"
                sh "docker tag helloworld:1.0.0 $dockerhub_user/helloworld:1.0.0"
                sh "docker push $dockerhub_user/helloworld:1.0.0"
                }
                   
}
            
            post{
                always{
                    echo "====++++always++++===="
                }
                success{
                    echo "====++++docker build executed successfully++++===="
                }
                failure{
                    echo "====++++docker build execution failed++++===="
                }
        
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
            archiveArtifacts artifacts: 'target/*.war', followSymlinks: false
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}
