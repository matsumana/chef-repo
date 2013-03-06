script 'install' do
  interpreter 'bash'
  flags '-e'
  code <<-'EOF'
    gem install growthforecast
    rbenv rehash
  EOF
end

cookbook_file '/tmp/spec.yaml' do
  source 'spec.yaml'
  group  'root'
  owner  'root'
  mode   '0644'
end

script 'install' do
  interpreter 'bash'
  flags '-e'
  code <<-'EOF'
    gfclient /tmp/spec.yaml myconfig Myapp
  EOF
end
