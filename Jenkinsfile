pipeline{
agent any 

stages{

stage('clean and build'){
steps{
       sh 'mn clean install'
}
       post {
              failure{
                    jira()
              }}
}

stage("SonarQube analysis") {
       
            steps {
              withSonarQubeEnv('sonarqube') {
                sh 'mvn sonar:sonar -Pprofile1'
              }
            }
          }
/* stage('Sonar') {
            environment {
                scannerHome=tool 'sonarqube'
            }
            steps{
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId:'Sonar_Cred', usernameVariable: 'USER', passwordVariable: 'PASS']]){
                    sh "mvn $USER:$PASS -Dsonar.host.url=http://ec2-18-224-155-110.us-east-2.compute.amazonaws.com:9000"
                }
            }
          }*/
        /*stage('SonarQube') 
       {
           
            environment {
                scannerHome=tool 'sonarqube'
            }
             //tools {scannerHome "SonarScanner"}
        steps{
             withSonarQubeEnv(credentialsId: 'nexus_credentials', installationName: 'sonar_server') {
                  sh '${scannerHome}/bin/sonar-scanner -Dproject.settings=./sonar-project.properties'
              }
              //sh 'npm run sonar'
           }
            
        }*/
    /* stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
            post {
              always{
         jiraGetProjectStatuses idOrKey: 'PRJ', site: 'jira'
              }}
          }*/
       
       
       
       
   stage('Nexus Artifact Upload') {
          steps{
             withCredentials([usernamePassword(credentialsId: 'nexus_credentials', passwordVariable: 'pass', usernameVariable: 'userId')]) {
            sh   'curl -F file=@target/demopipe-${BUILD_NUMBER}.war -u $userId:$pass http://ec2-18-224-155-110.us-east-2.compute.amazonaws.com:8081/nexus/content/repositories/devopstraining/freestyle/falcons/demopipe-${BUILD_NUMBER}.war'
             
             }}
          }
      
       
   

       
       
       
       
}
}
