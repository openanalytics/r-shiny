pipeline {
    
    agent any
    
    parameters {
        booleanParam(name: 'NOCACHE', defaultValue: false, description: 'Run docker build with --no-cache')
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }
    
    triggers {
        pollSCM('H/15 * * * *')
    }
    
    environment {
        NS = 'registry.openanalytics.eu/public'
    }
    
    stages {
    
        stage('Docker Build') {
        
            steps {
            
                script {
                     def image = docker.build(
                        "${env.NS}/r-shiny",
                        ("${params.NOCACHE}".toBoolean() ? '--no-cache ' : '') + "--build-arg http_proxy='http://webproxy.openanalytics.eu:8080' --build-arg https_proxy='http://webproxy.openanalytics.eu:8080' --build-arg no_proxy='localhost,127.0.0.0,127.0.0.1,openanalytics.eu' .")
                }
            
            }
            
        }
        
        stage('Docker Push') {
        
            steps {
            
                withDockerRegistry([
                        credentialsId: "eae5688d-c858-4757-a17f-65b68ca771da",
                        url: "https://registry.openanalytics.eu"]) {
                        
                    sh "docker push ${env.NS}/r-shiny"

                }
                
            }
            
        }
     
    }
    
}
