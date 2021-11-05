def newimage
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
    stage ('TF PLAN'){
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'accesskey_secretkey']]){
          sh 'pwd;cd terraform ; terraform init -input=false'
//                     sh 'pwd;cd terraform ; terraform workspace new ${environment}'
//                     sh 'pwd;cd terraform ; terraform workspace select ${environment}'
          sh "pwd;cd terraform ; terraform plan -input=false -out tfplan "
          sh 'pwd;cd terraform ; terraform show -no-color tfplan > tfplan.txt'     
      }
    
    }
//      stage('running image')
//     {
//       steps{
//         sh '''
//           docker run -p 8000:8000  newimage  
          
//         ''' 
//       }
//     }

    stage('Deploy'){
      steps{
        script{
          docker.withRegistry(
            'https://<aws-account-no>.dkr.ecr.<ecr-repo-server>.amazonaws.com',
            'ecr:<ecr-repo-server>:<jenkins-aws-id>'          
          )
          {
            newimage.push('<tag>')
          }     
        }
      
  }
}
    }
