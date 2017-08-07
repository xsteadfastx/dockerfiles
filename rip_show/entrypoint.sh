#!/bin/bash

set -e

echo "---> adding user"
groupadd -g $GROUPID trans
useradd -g $GROUPID -u $USERID -s /bin/zsh -m -G cdrom trans

if [ "$1" = "rip_show" ];then
        exec gosu trans /usr/local/bin/rip_show ${@:2}

elif [ "$1" = "zsh" ];then
        echo "---> preparing zsh"
        curl https://raw.githubusercontent.com/xsteadfastx/batcave/master/roles/zsh/files/zshrc -o /home/trans/.zshrc
        git clone --depth 1 https://github.com/zsh-users/antigen.git /home/trans/.antigen

        echo "---> fix permissions"
        chown -R trans:trans /home/trans

        echo "---> installing zsh plugins"
        gosu trans /bin/zsh -c "source /home/trans/.zshrc && antigen update"

        echo "---> entering container"
        exec gosu trans /bin/zsh

fi

exec "$@"
