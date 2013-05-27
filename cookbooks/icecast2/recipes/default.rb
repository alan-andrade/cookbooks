#
# Cookbook Name:: icecast2
# Recipe:: default
#
# Copyright 2013, Laberinto Radio
#
# All rights reserved - Do Not Redistribute
#

package("libxml2-dev"){ action :install }
package("libxslt-dev"){ action :install }
package("libcurl4-openssl-dev"){ action :install }
package("libvorbis-dev"){ action :install }

remote_file '/tmp/icecast.tar.gz' do
  source "http://downloads.xiph.org/releases/icecast/icecast-2.4-beta3.tar.gz"
  backup false
  action :create_if_missing
end

bash 'install icecast' do
  cwd '/tmp'
  code <<-EOS
  tar -zxf icecast.tar.gz
  cd icecast-2.3.99.3
  ./configure
  make
  make install
  EOS
end

directory node['icecast']['home'] do
  group 'icecast'
end

directory "#{node['icecast']['basedir']}/log" do
  group 'icecast'
end

['error.log', 'access.log'].each do |file|
  file "#{node['icecast']['basedir']}/log/#{file}" do
    owner 'icecast'
    group 'icecast'
  end
end

service 'icecast' do
  supports restart: true, reload: true
  action :start
end

template "#{node['icecast']['home']}/icecast.xml" do
  source 'icecast.xml.erb'
  mode 00644
  notifies :reload, resources(service: 'icecast')
end

cookbook_file "#{node['icecast']['home']}/disconnect" do
  owner 'icecast'
  source 'disconnect'
  mode 0755
end

user 'icecast' do
  home node['icecast']['home']
  supports manage_home: true
  shell '/bin/bash'
  system true
  action :create
end

group 'icecast' do
  members 'icecast'
  system true
  append false
  action :create
end

template "/etc/init.d/icecast" do
  source 'icecast.erb'
  mode 0755
end
