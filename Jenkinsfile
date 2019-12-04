pipeline {
	agent {
		docker {
			image 'lyf571321556/flutter_master_img:1.0.4'
		}
	}

	environment {
		DEV_ONLINE_HOST = '119.23.130.213'
		DEV_ONLINE_SSH_PORT = 8022
		DEV_ONLINE_USER = "ones-api"
		DEV_ONLINE_DATA_PATH = "/data/app/web/mobile"
		TAR_FILE_NAME = "ones-mobile-web-${BRANCH_NAME}-assets.tar.gz"
	}

	stages {
		stage('Prepare build') {
			options {
				retry(3)
			}
			steps {
				withCredentials([
						sshUserPrivateKey(credentialsId: 'dev.ones.team', keyFileVariable: 'SSH_PRIVATE_KEY')
				]) {
					sh '''
                    set +x
                    chmod 0700 /root/.ssh
                    cat $SSH_PRIVATE_KEY > ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa
                  '''
				}
			}
		}
		stage('prepare flutter env....') {
			steps {
				script {
					try {
						sh '''
                pwd
                ls -a
                export PATH="$FLUTTER_HOME/bin:$PATH"
                flutter --version
                pwd
                ls -a
                '''
					} catch (exc) {
						echo 'flutter init  failed！'
						sh 'exit 1'
					}
				}
			}
		}

		stage('flutter upgrade , test') {
			steps {
				script {
					sh '''
            export PATH="$FLUTTER_HOME/bin:$PATH"
            flutter upgrade
            '''
				}
			}
		}

		stage('flutter build') {
			steps {
				script {
					sh '''
                    export PATH="$FLUTTER_HOME/bin:$PATH"
                    flutter config --enable-web
                    flutter -v build web --release
                    ls
                    '''
				}
			}
		}

		stage('deployed') {
			options {
				retry(3)
			}
			steps {
				sh '''
                    pwd
                    ls ./build/web
                    rm -rf ${TAR_FILE_NAME}
                    tar zcvf ${TAR_FILE_NAME}  -C  ./build/web .
                    ls
                    '''
				echo 'start deployed...'
				sh "bash ./devops/scripts/deploy.sh development_online"
			}
		}


	}
}