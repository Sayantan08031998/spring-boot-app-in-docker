pipeline {
    agent none
        stages {
            stage('cloning git')
        
    {  agent any
      steps{
        checkout scm
      }
     }
            stage('Build') {
                agent {
                    docker {
                        image 'maven:latest'
                      
                       // args 'C:\Users\kshkr\.m2 /var/run/docker.sock:/var/run/docker.sock -u root'
                    }
                }
                steps {
                    sh ''
                    sh 'mvn -B -DskipTests clean package'
                    //stash includes: 'target/*.jar', name: 'targetfiles'
                }
            }
            //stage('package') {
              //  agent any
                //steps {
                  //  unstash 'targetfiles'
                    //sh 'docker build . -t testdocker'
                //}
            //}
        }
}
