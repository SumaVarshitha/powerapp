pipeline{
agent any 

stages{

stage('clean and build'){
steps{
       sh 'mvn clean install'
}

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
     stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
          }
       
       
       
       
       
   stage('Nexus Artifact Upload') {
          steps{
             withCredentials([usernamePassword(credentialsId: 'nexus_credentials', passwordVariable: 'pass', usernameVariable: 'userId')]) {
            sh   'curl -F file=@target/demopipe-${BUILD_NUMBER}.war -u $userId:$pass http://ec2-18-224-155-110.us-east-2.compute.amazonaws.com:8081/nexus/content/repositories/devopstraining/freestyle/falcons/demopipe-${BUILD_NUMBER}.war'
             
             }}
          }

 stage('Chef and Tomcat'){
 steps{
        sh 'sudo /home/ec2-user/apache-tomcat-8.5.47/bin/./startup.sh '
        sh 'sudo git -C /home/ec2-user/chef/tomcat pull'
 sh 'sudo rm -rf ~/chef/tomcat/tomcat/recipes/local-mode-cache' 
 sh 'sudo chef-solo -c /home/ec2-user/chef/tomcat/tomcat/recipes/solo.rb -j /home/ec2-user/chef/tomcat/tomcat/recipes/dna.json'
 }
 }
  
}
        post { 
         success { 
            echo 'notified to slack '
            slackSend (color: '#00FF00', message: " JOB SUCCESSFUL: Job '${JOB_NAME} [${BUILD_NUMBER}]' (${BUILD_URL})")
         }
         failure {
            echo 'notified to slack'
            slackSend (color: '#FF0000', message: " JOB FAILED: Job '${JOB_NAME} [${BUILD_NUMBER}]' (${BUILD_URL})")
         }
    }
}
