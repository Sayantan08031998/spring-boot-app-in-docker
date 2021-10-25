pipeline {
  agent any 
  stages {
    stage('cloning git')
    {
      steps{
        checkout scm
      }
     }
    stage('building image')
    {
      steps{
        sh '''
          docker build -t newImage .
          
        ''' 
      }
    }
     stage('running image')
    {
      steps{
        sh '''
          docker run newImage 
          
        ''' 
      }
    }
    
  }
}
