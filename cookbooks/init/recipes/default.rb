script 'selinux_disabled' do
  interpreter 'bash'
  flags '-e'
  code <<-'EOF'
    setenforce 0
  EOF
end
cookbook_file '/etc/selinux/config' do
  source 'etc/selinux/config'
  group  'root'
  owner  'root'
  mode   '0644'
end

script 'selinux_iptables' do
  interpreter 'bash'
  flags '-e'
  code <<-'EOF'
    chkconfig ip6tables off
    chkconfig iptables off
    service ip6tables stop
    service iptables stop
  EOF
end
