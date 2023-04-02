pipeline {
  agent any
  stages {
    stage('Initialize'){
      steps {
        script {
          def dockerHome = tool 'docker'
          env.PATH = "${dockerHome}/bin:${env.PATH}"
        }
      }
    }
    stage('Clone Repository') {
      steps {
        script {
          checkout scm
        }
      }
    }

    stage('Build and push') {
      steps {
        script {
          docker.withRegistry('http://10.4.125.116:5000/moodle') {
            def app = docker.build("moodle")
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
          }
        }
      }
    }
  }
}
