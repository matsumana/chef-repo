cookbook_file '/etc/yum.repos.d/td.repo' do
  source 'etc/yum.repos.d/td.repo'
  group  'root'
  owner  'root'
  mode   '0644'
end

script 'yum_update' do
  interpreter 'bash'
  flags '-e'
  code <<-'EOF'
    yum update
  EOF
end

%w{
   td-agent
}.each do |package_name|
  package package_name do
    action :install
  end
end

cookbook_file '/etc/td-agent/td-agent.conf' do
  source 'etc/td-agent/td-agent.conf'
  group  'root'
  owner  'root'
  mode   '0644'
end

script 'gem_install' do
  interpreter 'bash'
  flags '-e'
  code <<-'EOF'
    /usr/lib64/fluent/ruby/bin/fluent-gem install fluent-plugin-parser
    /usr/lib64/fluent/ruby/bin/fluent-gem install fluent-plugin-rewrite-tag-filter
    /usr/lib64/fluent/ruby/bin/fluent-gem install fluent-plugin-forest
    /usr/lib64/fluent/ruby/bin/fluent-gem install fluent-plugin-numeric-counter
    /usr/lib64/fluent/ruby/bin/fluent-gem install fluent-plugin-datacounter
    /usr/lib64/fluent/ruby/bin/fluent-gem install fluent-plugin-growthforecast
  EOF
end

script 'start_daemon' do
  interpreter 'bash'
  flags '-e'
  code <<-'EOF'
    chkconfig td-agent on
    chkconfig td-agent --list
    service td-agent start
  EOF
end
