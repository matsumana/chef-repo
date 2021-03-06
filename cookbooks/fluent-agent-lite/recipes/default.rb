# clone済みだとエラーになるので、ディレクトリがない場合だけ実行する 
unless File.directory?("/usr/local/src/fluent-agent-lite") then
  script 'install' do
    interpreter 'bash'
    flags '-e'
    code <<-'EOF'
      git clone git://github.com/tagomoris/fluent-agent-lite.git /usr/local/src/fluent-agent-lite
      cd /usr/local/src
      fluent-agent-lite/bin/install.sh
    EOF
  end
end

# デフォルト設定ファイルのLogFormatの末尾に%Dを追加しただけです。
# LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
# ↓
# LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %D" combined
cookbook_file '/etc/httpd/conf/httpd.conf' do
  source 'etc/httpd/conf/httpd.conf'
  group  'root'
  owner  'root'
  mode   '0644'
end

cookbook_file '/etc/fluent-agent-lite.conf' do
  source 'etc/fluent-agent-lite.conf'
  group  'root'
  owner  'root'
  mode   '0644'
end

script 'start_deamon' do
  interpreter 'bash'
  flags '-e'
  code <<-'EOF'
    chkconfig fluent-agent-lite on
    chkconfig --list fluent-agent-lite
    service fluent-agent-lite start
  EOF
end
