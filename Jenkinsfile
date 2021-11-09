
pipeline {  
  agent any 
	options {
		
                timestamps ()
                ansiColor('xterm')
            }
  
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

//    stage('building image and deploy')
//      steps{
//         sh '''
//           docker build -t newimage:1 .
// 	  //stash includes: 'newimage:1', name: 'createdimage'
          
//         ''' 
//        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'accesskey_secretkey']]){
// 	       script{
// 		       docker.withRegistry(
// 			       'https://749266080072.dkr.ecr.ap-south-1.amazonaws.com',
// 			       'ecr:ap-south-1:accesskey_secretkey'
// 			       ){
// 			       def myimage= docker.build('newrepo')
// 			       myimage.push('new')   
				//unstash 'createdimage'
// 				newimage.push('1')
// 				 }
// 			}
//        }   
//       }
//     }
	  
	  
//      stage('running image')
//     {
//       steps{
//         sh '''
//           docker run -p 8000:8000  newimage  
          
//         ''' 
//       }
//     }

//     stage('Deploy'){
//       steps{
// 	       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'accesskey_secretkey']]){
// 		       script{
// 			       docker.withRegistry(
// 				       'https://749266080072.dkr.ecr.ap-south-1.amazonaws.com',
				       
// 				       'ecr:ap-south-1:accesskey_secretkey'
// 				   	){
// 				       //unstash 'createdimage'
// 				       newimage.push('1')
// 				       }
// 			       }
// 		       }
// 	      	}
// 	    }


}
}



//$data.aws_caller_identity.current.account_id
//749266080072

