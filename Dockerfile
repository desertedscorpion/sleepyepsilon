FROM taf7lwappqystqp4u7wjsqkdc7dquw/heavytombstone
MAINTAINER “Emory Merryman” emory.merryman+DoTDeCocXJroqaWu@gmail.com>
ENV KEY_ID="2D2D81DA" PASS_REPO="git@github.com:AFnRFCb7/lanterngold.git"
USER root
RUN dnf update --assumeyes && dnf install --assumeyes bash-completion pass git cronie gnupg gnupg2 findutils openssh-clients sudo a2ps && dnf update --assumeyes && dnf clean all && echo "${LUSER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${LUSER} && chmod 0444 /etc/sudoers.d/${LUSER}
COPY push_password_store.sh /usr/local/bin/push_password_store
COPY paper_backup.sh /usr/local/bin/paper_backup
COPY config /home/${LUSER}/.ssh/config
RUN chmod 0555 /usr/local/bin/push_password_store && chmod 0555 /usr/local/bin/paper_backup && chown --recursive ${LUSER}:${LUSER} /home/${LUSER}/.ssh
USER ${LUSER}
VOLUME /home/${LUSER}/private
VOLUME /home/${LUSER}/report
RUN mkdir /home/${LUSER}/bin && chmod 0700 /home/${LUSER}/.ssh
RUN chmod 0600 /home/${LUSER}/.ssh/config
RUN echo -e "* * * * * /usr/local/bin/push_password_store\n" | crontab -
RUN mkdir --parents /home/${LUSER}/running/desertedscorpion /home/${LUSER}/running/AFnRFCb7
CMD (sudo crond -p) && cp /home/${LUSER}/private/id_rsa /home/${LUSER}/.ssh/id_rsa && chmod 0600 /home/${LUSER}/.ssh/id_rsa && (gpg --allow-secret-key- --import /home/${LUSER}/private/secret.key || true ) &&  (gpg2 --allow-secret-key- --import /home/${LUSER}/private/secret.key || true ) && pass init ${KEY_ID} && git config --global user.email "emory.merryman@gmail.com" && git config --global user.name "Emory Merryman" && pass git init && pass git remote add origin ${PASS_REPO} && pass git fetch origin master && pass git checkout master && pass git rebase origin/master && git -C /home/${LUSER}/running/desertedscorpion clone git@github.com:desertedscorpion/whitevenus.git && git -C /home/${LUSER}/running/AFnRFCb7 clone git@github.com:AFnRFCb7/bulldozerstrong.git && /usr/bin/bash
