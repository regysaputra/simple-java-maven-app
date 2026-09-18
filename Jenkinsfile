// 1. Define triggers at the top level for Scripted Pipelines
properties([
    pipelineTriggers([pollSCM('H/2 * * * *')])
])

node {
    stage('Checkout') {
        // 2. Scripted pipelines require an explicit checkout step
        checkout scm
    }

    // 3. Define the Maven Docker image and mount the local .m2 cache
    docker.image('maven:3.8-eclipse-temurin-17').inside('-v $HOME/.m2:/root/.m2') {

        stage('Build') {
            // Replaces 'npm install'
            sh 'mvn clean compile'
        }

        stage('Test') {
            // Replaces the bash script with standard Maven testing
            sh 'mvn test'
        }
    }
}