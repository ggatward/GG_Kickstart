pipeline {

  agent {
    label "master"
  }

  environment {
    // Global Vars
    JENKINS_TAG = "${JOB_NAME}.${BUILD_NUMBER}".replace("/", "-")
    JOB_NAME = "${JOB_NAME}".replace("/", "-")

    GIT_SSL_NO_VERIFY = true
    GIT_CREDENTIALS = credentials('jenkins-git-creds')
    GIT_DOMAIN = "github.com"
    GIT_PROJECT = "ggatward"
    APP_NAME = "GG_Kickstart"
  }

  options {
    buildDiscarder(logRotator(numToKeepStr:'10'))
    timeout(time: 15, unit: 'MINUTES')
    ansiColor('xterm')
    timestamps()
  }

  stages {

    stage("Prepare environment for master deploy") {
      agent {
        node {
          label "master"
        }
      }
      when {
        expression { GIT_BRANCH ==~ /(.*master)/ }
      }
      steps {
        script {
          // Arbitary Groovy Script
          echo '### Running master branch ###'
          sh 'echo hello-master'
        }
      }
    }

    stage("Prepare environment for development deploy") {
      agent {
        node {
          label "master"
        }
      }
      when {
        expression { GIT_BRANCH ==~ /(.*development)/ }
      }
      steps {
        script {
          // Arbitary Groovy Script
          echo '### Running development branch ###'
          sh 'echo hello-development'
        }
      }
    }





  }
}
