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
                        image 'maven:3.8.1-adoptopenjdk-11'
                        args "-v //tmp/maven:/var/maven/.m2 -e MAVEN_CONFIG=//var/maven/.m2"
                      
//                        args '-v /root/.m2:/root/.m2'
                    }
                    
                }
                environment {
                  HOME="."
                }
                steps {
                    //sh 'mvn --version'
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
