#!/bin/bash

echo "参数: $@"
#DO_PATH=/data/app/bangwork.com/downloads/
DO_PATH=/data/app/bangwork.com/downloads/
FILE_NAME=`ls *.7z`
NAME=${FILE_NAME%.*}
UP_PATH=/data/nginx/update/v1/apps/1100/zh-CN/
#UP_PATH=/data/nginx/update/v1/apps/0100/en/

if [[ $SERVER == ones.ai ]];then
	#SERVERS_IP=10.46.96.120,10.46.96.114
	SERVERS_IP=ones-deploy-env
	CONF_FILE=default_updateConfig.txt
fi

if [[ $SERVER == sandbox.ones.ai ]];then
	SERVERS_IP=192.168.42.1
	CONF_FILE=sandbox_updateConfig.txt
fi
if [[ $SERVER == dev.ones.team ]];then
        SERVERS_IP=119.23.130.213
        CONF_FILE=default_updateConfig.txt
fi
log_print()
{
        if [ $? != 0 ] ; then echo "ERROR: Command returns the value NO 0"  ; exit 1 ; fi
}

upload_server(){
        OLD_IFS="$IFS"
        IFS=","
        arr=($SERVERS_IP)
        IFS="$OLD_IFS"
        for SERVER_IP in ${arr[@]}
        do
		scp -P8022 $FILE_NAME  jenkins@${SERVER_IP}:~/tmp
		log_print
        done
}

update_apkurl(){

        OLD_IFS="$IFS"
        IFS=","
        arr=($SERVERS_IP)
        IFS="$OLD_IFS"
        for SERVER_IP in ${arr[@]}
        do
		ssh -p8022 jenkins@${SERVER_IP} "cd ~/tmp ;7za x -y  ${FILE_NAME} *.apk  -o$DO_PATH  ; cd $DO_PATH && rm -rf ones_release_default.apk && ln -s ${NAME}_default.apk  ones_release_default.apk" 
		log_print
	#	nginx_conf
	#	log_print
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

echo "上传apk 包"
upload_server 

echo "更新下载包"
update_apkurl

if [[ $UPDATE == yes ]]; then
	echo "更新升级文件"
	upgrade_config	
fi

#echo "清理残留文件"
#file_clear  

