pipeline {
    agent none
    stages {
        stage('cloning git'){
      agent any
         steps{
	      script{
		      dir("New")
                        {
                            checkout scm
                        }
                    }        
      		}
     }
        stage('Build') {
            agent {
                docker {
                    image 'maven:3.8.3-openjdk-8'
                    //customWorkspace 'C:/Windows/System32/config/systemprofile/AppData/Local/Jenkins/.jenkins/workspace'
                    //args "-v //tmp/maven:/var/maven/.m2 -e MAVEN_CONFIG=//var/maven/.m2"
                    //args '-v /root/.m2:/root/.m2'
                    //reuseNode true
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
