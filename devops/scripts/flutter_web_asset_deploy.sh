#!/bin/bash

echo "参数: $@"
DO_PATH=/data/app/mobile/
FILE_NAME=`ls ones_ai_flutter_for_web_*.tar.gz`
NAME=${FILE_NAME%.*}
UP_PATH=/data/nginx/

if [[ $SERVER == ones.ai ]];then
	SERVERS_IP=39.108.105.21
fi

if [[ $SERVER == beta.myones.net ]];then
	SERVERS_IP=120.77.250.189
fi
if [[ $SERVER == dev.ones.team ]];then
        SERVERS_IP=119.23.130.213
fi
log_print()
{
        if [ $? != 0 ] ; then echo "ERROR: Command returns the value NO 0"  ; exit 1 ; fi
}

upload_asset_to_server(){
        OLD_IFS="$IFS"
        IFS=","
        arr=($SERVERS_IP)
        IFS="$OLD_IFS"
        for SERVER_IP in ${arr[@]}
        do
		scp -P8022 $FILE_NAME  jenkins@${SERVER_IP}:"$DO_PATH"
		log_print
        done
}

unzip_asset_to_workspace(){

        OLD_IFS="$IFS"
        IFS=","
        arr=($SERVERS_IP)
        IFS="$OLD_IFS"
        for SERVER_IP in ${arr[@]}
        do
		ssh -p8022 jenkins@${SERVER_IP} "cd $DO_PATH ;tar -zxf ${FILE_NAME}; cd $DO_PATH && rm -rf ${FILE_NAME}" 
		log_print
        done

}

nginx_conf(){
		ssh -p8022 jenkins@${SERVER_IP} " sed -i 's/ones_release_v.*apk/${NAME}_default.apk/g'  /usr/local/nginx/conf/sites-available/sandbox.ones.ai  "
}



upgrade_config(){
        OLD_IFS="$IFS"
        IFS=","
        arr=($SERVERS_IP)
        IFS="$OLD_IFS"
        for SERVER_IP in ${arr[@]}
        do
		ssh -p8022 jenkins@${SERVER_IP} "cd $UP_PATH ; 7za x -y ~/tmp/${FILE_NAME} -o. '-x!*.apk' " 
		log_print
		# 是否强制升级
		ssh -p8022 jenkins@${SERVER_IP} "find ${UP_PATH} -type f -exec sed -i -e 's/.*forcibly.*/\"forcibly\": ${forcibly},/g' {} \;" 
		log_print
        done
	}

file_clear(){
	OLD_IFS="$IFS"
        IFS=","
        arr=($SERVERS_IP)
        IFS="$OLD_IFS"
        for SERVER_IP in ${arr[@]}
        do
		ssh -p8022 jenkins@${SERVER_IP} "rm -rf ~/tmp/*"
                log_print
        done
}

echo "上传资源包..."
upload_asset_to_server 

echo "解压资源包..."
unzip_asset_to_workspace

if [[ $UPDATE == yes ]]; then
	echo "更新配置文件。。。。todo"
	# upgrade_config	
fi

