#!/bin/bash

PHONETIC=${HOME}/running/desertedscorpion/whitevenus/phonetic.sh &&
TSTAMP=$(date +%a%Y%b%d%H%M%S) &&
HASH=$(pass git rev-parse HEAD) &&
UUID=$(uuidgen) &&
GPG=$(pass show gpg/2016/2018 | ${PHONETIC}) &&
EMORY=$(pass show systems/yardmorbid/users/emory/password | ${PHONETIC}) &&
ADMIN=$(pass show systems/yardmorbid/users/admin/password | ${PHONETIC}) &&
(cat > ${HOME}/report/paper-backup.txt <<EOF
TSTAMP=${TSTAMP}
HASH=${HASH}
UUID=${UUID}
GPG=${GPG}
EMORY=${EMORY}
ADMIN=${ADMIN}
EOF
) &&
a2ps -o ${HOME}/report/paper-backup.ps -1 ${HOME}/report/paper-backup.txt &&
echo ${TSTAMP}, ${HASH}, ${UUID} >> /home/emory/running/AFnRFCb7/bulldozerstrong/paper-backup.csv &&
git -C /home/emory/running/AFnRFCb7/bulldozerstrong add paper-backup.csv &&
git -C /home/emory/running/AFnRFCb7/bulldozerstrong commit -am "made a paper backup - ${UUID}" &&
git -C /home/emory/running/AFnRFCb7/bulldozerstrong push origin master &&
true

