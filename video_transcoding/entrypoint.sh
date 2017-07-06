#!/bin/sh

set -e

if [ "$1" = "video_transcoding" ];then
        groupadd -g $GROUPID trans
        useradd -g $GROUPID -u $USERID -s /bin/zsh -m -G cdrom trans
        curl https://raw.githubusercontent.com/xsteadfastx/batcave/master/roles/zsh/files/zshrc -o /home/trans/.zshrc
        git clone --depth 1 https://github.com/zsh-users/antigen.git /home/trans/.antigen
        chown -R trans:trans /home/trans
        gosu trans /bin/zsh -c "source /home/trans/.zshrc && antigen update"
        exec gosu trans /bin/zsh
fi

exec "$@"
