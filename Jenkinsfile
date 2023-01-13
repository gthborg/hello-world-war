pipeline{
    agent any
    options {
  buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '5', numToKeepStr: '5')
}

    tools {
        maven 'Maven'
    }
    stages{
        stage("Code Checkout"){
            steps{
                echo "========executing Code Checkout from feature branch========"
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'myGitCredentials', url: 'https://github.com/gthborg/hello-world-war.git']])
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
        /*stage("Upload artifact "){
            steps{
                echo "========Build========"
                sh 'mvn -s settings.xml deploy'                
            }
            post{
                success{
                    echo "========Build completed========"
                }
                failure{
                    echo "========Build failed========"
                }
            }
        }*/
        stage("Execute SonarScan"){
            steps {
                script { 
                    //def scannerHome = tool name: 'mySonar';
                    withSonarQubeEnv("mySonar") {
                        sh "${tool("mySonarScanner")}/bin/sonar-scanner \
                        -Dsonar.projectKey=hello-world-war \
                        -Dsonar.sources=. \
                        -Dsonar.java.binaries=target \
                        -Dsonar.host.url=http://172.31.6.11:9000 \
                        -Dsonar.login=sqa_c2e90fe5764b420ac7ce57f08193b6cfe57dcb73"
                    }
               }
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
