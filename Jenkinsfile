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
          docker build -t newimage .
          
        ''' 
      }
    }
     stage('running image')
    {
      steps{
        sh '''
          docker run -p 8000:8000  newimage  
          
        ''' 
      }
    }
    
  }
}
