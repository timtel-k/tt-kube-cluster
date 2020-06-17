properties([
        parameters(
                [
                        stringParam(
                                name: 'HELLO_NAME',
                                defaultValue: 'Pit'
                        )
                ]
        )
])

pipeline {
    agent {
        kubernetes {
            label 'deploy-service-pod'
            defaultContainer 'jnlp'
            yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    job: deploy-service
spec:
  containers:
  - name: hello
    image: tv733/helloworldjava
    command: ["cat"]
    tty: true
"""
        }
    }

    stages {
        stage('Hello world ') {
            steps {
                container('hello') {
                    script {
                        sh "echo HELLO ${params.HELLO_NAME}"
                    }
                }
            }
        }
    }
}
