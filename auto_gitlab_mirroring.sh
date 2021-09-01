#!/bin/bash
ID=backup
PW=backup_passwd

#GIT_URL={GITLAB_ADDRESS}:{GITLAB_PORT}/{USERNAME}/
GIT_URL=10.72.132.112:30000/backup/

USER_PATH=/home/git/data/repositories/
USERS=`cd $USER_PATH && ls -d */`

while [ "$USERS" != "" ];
do
        # get NEW_USER
        NEW_USER=${USERS%%/*};
        USERS=${USERS#*/};
        USERS=${USERS:1};

        # get NEW_PROJECT
        PROJECTS=`cd ${USER_PATH}${NEW_USER} && ls -d */`

        while [ "$PROJECTS" != "" ];
        do
                NEW_PROJECT=${PROJECTS%%/*};
                PROJECTS=${PROJECTS#*/};
                PROJECTS=${PROJECTS:1};

                # when has wiki keyward
                if [[ "$NEW_PROJECT" == *".wiki."* ]];
                        then continue;
                fi

                # set PROJECT_PATH, GIT_MIRRORING_URL up
                PROJECT_PATH="${USER_PATH}${NEW_USER}/${NEW_PROJECT}/";
                GIT_MIRRORING_URL="https://${ID}:${PW}@${GIT_URL}${NEW_PROJECT}";

                cd $PROJECT_PATH && git push --mirror $GIT_MIRRORING_URL
        done
done

# EXAMPLES

# git push --mirror 'https://backup:backup_passwd@10.72.132.112:30000/tolriaz/test.git'

# /home/git/data/repositories/yoonjin671/rpi-k8s-gpio.git/
# https://10.72.132.112:30000/backup/rpi-k8s-gpio.git
