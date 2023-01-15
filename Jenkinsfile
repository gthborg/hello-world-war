pipeline{
    agent any
    tools {
        maven 'Maven'
    }
    stages{
        stage("all stages"){
            steps{
                echo "========GIT step========"
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'mynew', url: 'https://github.com/gthborg/hello-world-war.git']])
            }
            post{
                success{
                    echo "========GIT success========"
                }
                failure{
                    echo "========GIT failed========"
                }
            }
        }
        stage("Shell Execute"){
            steps{
                echo "========Shell step========"
                sh 'echo "New Pipeline Page"'
            }
            post{
                success{
                    echo "========Shell success========"
                }
                failure{
                    echo "========Shell failed========"
                }
            }
        }
        stage("Build Execute"){
            steps{
                echo "========Build step========"
                sh 'mvn clean install'
            }
            post{
                success{
                    echo "========Build success========"
                }
                failure{
                    echo "========Build failed========"
                }
            }
        }
    }
}