pipeline{
agent any 

stages{

stage('clean and build'){
steps{
       sh 'mvn clean'
       sh 'mvn install'
}

}

stage("SonarQube analysis") {
       
            steps {
              withSonarQubeEnv('sonarqube') {
                sh 'mvn sonar:sonar'
              }
            }
          }
  
       
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
 sh 'rm -rf ~/chef/tomcat/tomcat/recipes/local-mode-cache' 
 sh 'chef-solo -c /home/ec2-user/chef/tomcat/tomcat/recipes/solo.rb -j /home/ec2-user/chef/tomcat/tomcat/recipes/dna.json'
 }
 }
  
}
}
