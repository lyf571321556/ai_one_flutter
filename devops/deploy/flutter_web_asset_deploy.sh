#!/bin/bash

echo "参数: $@"
read REMOTE_HOST SSH_PORT REMOTE_USER REMOTE_SAVE_PATH LOCAL_FILE_NAME <<<$@
echo $REMOTE_HOST
echo $SSH_PORT
echo $REMOTE_USER
echo $REMOTE_SAVE_PATH
echo $LOCAL_FILE_NAME

log_print()
{
        if [ $? != 0 ] ; then echo "ERROR: Command returns the value NO 0"  ; exit 1 ; fi
}

upload_asset_to_server(){
        OLD_IFS="$IFS"
        IFS=","
        arr=($REMOTE_HOST)
        IFS="$OLD_IFS"
        for SERVER_IP in ${arr[@]}
        do
		scp -P8022 $LOCAL_FILE_NAME  ${REMOTE_USER}@${SERVER_IP}:${REMOTE_SAVE_PATH}
		log_print
        done
}

unzip_asset_to_workspace(){

        OLD_IFS="$IFS"
        IFS=","
        arr=($REMOTE_HOST)
        IFS="$OLD_IFS"
        for SERVER_IP in ${arr[@]}
        do
		ssh -p8022 ${REMOTE_USER}@${SERVER_IP} "cd ${REMOTE_SAVE_PATH} ;tar -zxf ${LOCAL_FILE_NAME}; cd $REMOTE_SAVE_PATH && rm -rf ${LOCAL_FILE_NAME}"
		log_print
        done

}


file_clear(){
	OLD_IFS="$IFS"
        IFS=","
        arr=($REMOTE_HOST)
        IFS="$OLD_IFS"
        for SERVER_IP in ${arr[@]}
        do
		ssh -p8022 ${REMOTE_USER}@${REMOTE_HOST} "rm -rf ~/tmp/*"
                log_print
        done
}

echo "上传资源包..."
upload_asset_to_server 

echo "解压资源包..."
unzip_asset_to_workspace

echo "${LOCAL_FILE_NAME}部署成功..."


