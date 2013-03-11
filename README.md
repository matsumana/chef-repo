#■fluent-agent-liteのインストール時に依存症を解決出来ないライブラリをインストール ※CentOS6.3でのみ確認
    # yum install -y cpan
    # perl -MCPAN -e 'install IPC::Cmd'

tail対象のログファイルが無いとfluent-agent-liteが起動しないので、Apacheが起動するようにしておきます。

fluent-agent-liteが起動しない場合はtail対象のログファイルがあるか確認してください。

    # chkconfig httpd on
    # chkconfig httpd --list
    # service httpd start

#■GrowthForecast
#####※CentOS6.3でのみ確認
以下を参照にしました。ありがとうございます。

[GrowthForecast を CentOS 6.3 にインストールして Supervisor で管理してみた](http://d.hatena.ne.jp/inouetakuya/20130211/1360570283)  
[GrowthForecast導入&Supervisorで起動を管理](http://blog.glidenote.com/blog/2012/07/05/growthforecast-supervisor/)

    # yum install pkgconfig glib2-devel gettext libxml2-devel pango-devel cairo-devel cpan
    # perl -MCPAN -e 'install IPC::Cmd'
    # useradd growthforecast
    # passwd growthforecast
    # su - growthforecast
 
    $ curl -kL http://install.perlbrew.pl | bash
    $ echo '[[ -s "$HOME/perl5/perlbrew/etc/bashrc" ]] && source "$HOME/perl5/perlbrew/etc/bashrc"' >> .bash_profile
    $ source $HOME/perl5/perlbrew/etc/bashrc
    $ perlbrew available
    $ perlbrew install perl-5.16.2
    $ perlbrew switch perl-5.16.2
    $ perl -v
    $ perlbrew install-cpanm
    $ cpanm -n GrowthForecast
    $ mkdir /home/growthforecast/data
    $ mkdir /home/growthforecast/log
    $ growthforecast.pl --data-dir=/home/growthforecast/data > /home/growthforecast/log/growthforecast.log 2> /home/growthforecast/log/growthforecast.err &

#■rbenv + ruby-buildのインストール手順
#####※CentOS6.3でのみ確認
    # rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    # yum check-update
    # yum update
    # yum -y install zlib-devel
    # yum -y install httpd-devel
    # yum -y install openssl-devel
    # yum -y install curl-devel
    # yum -y install ncurses-devel
    # yum -y install gdbm-devel
    # yum -y install readline-devel
    # yum -y install sqlite-devel

    # cd /usr/local
    # git clone git://github.com/sstephenson/rbenv.git
    # mkdir rbenv/shims rbenv/versions
    # groupadd rbenv
    # chgrp -R rbenv rbenv
    # chmod -R g+rwxXs rbenv

    # cd /usr/local/src/
    # git clone https://github.com/sstephenson/ruby-build.git
    # cd ruby-build
    # ./install.sh

    # vi /etc/profile.d/rbenv.sh
    ↓ 以下の内容をコピペ
    export RBENV_ROOT="/usr/local/rbenv"
    export PATH="/usr/local/rbenv/bin:$PATH"
    eval "$(rbenv init -)"

    # visudo
    ↓
    Defaults    env_reset
    Defaults    env_keep =  "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR LS_COLORS"
    Defaults    env_keep += "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE"
    Defaults    env_keep += "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES"
    Defaults    env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"
    Defaults    env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY"
    ※このブロックの末尾にこれを追加
    Defaults    env_keep += "PATH"

    # which rbenv
    # rbenv install -l
    # rbenv install 1.9.3-p392
    # rbenv global 1.9.3-p392
    # ruby -v
    # gem install chef --no-rdoc --no-ri
    # rbenv rehash
