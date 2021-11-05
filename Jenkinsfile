pipeline {
    agent any
    stages {
        stage('cloning git') {
            steps{
                checkout scm
                }
        }
        stage('Build') {
            agent {
                docker {
                    image 'maven:3.8.3-openjdk-8'
                    run -p 8000:8000  maven:3.8.3-openjdk-8
                    //args "-v //tmp/maven:/var/maven/.m2 -e MAVEN_CONFIG=//var/maven/.m2"
                    //args '-v /root/.m2:/root/.m2'
                    reuseNode true
                    }
                    
                }
                //environment {
                //  HOME="."
               // }
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
