def newimage
pipeline {  
  agent any 
  stages {
    stage('cloning git'){
      steps{
	      script{
		      dir("New")
                        {
                            checkout scm
                        }
                    }        
      		}
     }
    stage('building image')
    {
      steps{
        sh '''
          docker build -t newimage:1 .
          
        ''' 
      }
    }
    stage ('TF PLAN'){
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'accesskey_secretkey']]){
          sh 'pwd;cd New; terraform init -input=false'
			//                     sh 'pwd;cd terraform ; terraform workspace new ${environment}'
			//                     sh 'pwd;cd terraform ; terraform workspace select ${environment}'
          sh "pwd;cd New; terraform plan -input=false -out tfplan "
          sh 'pwd;cd New; terraform show -no-color tfplan > tfplan.txt'     
      }
    
    }
}
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    def plan = readFile 'New/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'accesskey_secretkey']]){
                    sh "pwd;cd New; terraform apply -input=false tfplan"
                }
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
            'https://${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-south-1.amazonaws.com',
            'ecr:ap-south-1:accesskey_secretkey'          
          ){
            newimage.push('1')
          }     
        }
	}
	}
}
}
