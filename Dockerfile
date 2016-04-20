FROM taf7lwappqystqp4u7wjsqkdc7dquw/heavytombstone
MAINTAINER “Emory Merryman” emory.merryman+DoTDeCocXJroqaWu@gmail.com>
ENV KEY_ID="2D2D81DA" PASS_REPO="git@github.com:AFnRFCb7/lanterngold.git"
USER root
RUN dnf update --assumeyes && dnf install --assumeyes pass git cronie gnupg2 openssh-clients byobu && dnf update --assumeyes && dnf clean all
VOLUME /home/${LUSER}/private
RUN mkdir /home/${LUSER}/bin /home/${LUSER}/.ssh && chmod 0700 /home/${LUSER}/.ssh
COPY push_password_store.sh /home/${LUSER}/bin/push_password_store
COPY config /home/${LUSER}/.ssh/config
RUN chown --recursive ${UID}:${GID} /home/${LUSER}/.ssh && chown --recursive ${UID}:${GID} /home/${LUSER}/private && chmod 0500 /home/${LUSER}/bin/push_password_store && chmod 0600 /home/${LUSER}/.ssh/config
USER ${LUSER}
RUN echo "* * * * * /home/${LUSER}/push_password_store" | crontab -
USER root
CMD /usr/bin/bash # cp /home/${LUSER}/private/id_rsa /home/${LUSER}/.ssh/id_rsa && chmod 0600 /home/${LUSER}/.ssh/id_rsa && echo A && stat /home/${LUSER}/private/secret.key && (gpg2 --allow-secret-key- --import /home/${LUSER}/private/secret.key || true ) && echo B && pass init ${KEY_ID} && git config --global user.email "emory.merryman@gmail.com" && git config --global user.name "Emory Merryman" && pass git init && pass git remote add origin ${PASS_REPO} && echo C && /usr/bin/bash # && pass git fetch origin master && git checkout origin/master && /usr/bin/bash
