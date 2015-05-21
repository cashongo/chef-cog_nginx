#
# Cookbook Name:: cog_c7nginx
# Recipe:: default
#
# Copyright (C) 2015 Lauri Jesmin
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'yum-epel::default'

cookbook_file "nginx-release-centos-7-0.el7.ngx.noarch.rpm" do
  path "/root/nginx-release-centos-7-0.el7.ngx.noarch.rpm"
  action :create_if_missing
end


package "/root/nginx-release-centos-7-0.el7.ngx.noarch.rpm" do
  action :install
  not_if { File.exists?('/etc/yum.repos.d/nginx.repo') }
end

package ['yum-plugin-priorities','yum-utils'] do
  action :install
end

#Alter priorities
#this can also be done this way
#yum-config-manager --setopt="nginx.priority=1" --save
#

execute "set nginx priority" do
  command 'yum-config-manager --setopt="nginx.priority=1" --save'
  action :run
end

package "nginx" do
  action :install
end

cookbook_file "sites.conf" do
  path "/etc/nginx/conf.d/sites.conf"
  action :create
  owner "root"
  group "root"
  mode "0644"
end

directory '/etc/nginx/sites-enabled' do
  action :create
  owner 'root'
  group 'root'
  mode '0755'
end

directory '/etc/nginx/sites-available' do
  action :create
  owner 'root'
  group 'root'
  mode '0755'
end

directory '/etc/nginx/include' do
  action :create
  owner 'root'
  group 'root'
  mode '0755'
end

cookbook_file 'fastcgi_cache.conf' do
  action :create
  mode '0644'
  owner 'root'
  group 'root'
  path '/etc/nginx/conf.d/fastcgi_cache.conf'
end

cookbook_file 'piwik_nocache.conf' do
  action :create
  mode '0644'
  owner 'root'
  group 'root'
  path '/etc/nginx/conf.d/piwik_nocache.conf'
end


%w[pma.conf  wordpress.conf  wordpress-w3-total-cache.conf  wordpress-wp-super-cache.conf  wordpress-restrictions.conf dokuwiki.conf php.conf monitoring.conf piwik.conf fcgi_piwik_cache.conf  fcgi_piwik_long_cache.conf].each do |nginxconf|
  cookbook_file nginxconf do
    action :create
    path "/etc/nginx/include/#{nginxconf}"
    mode '0644'
    owner 'root'
    group 'root'
  end
end

cog_nginx_site "monitoring" do
	siteid '00-monitoring'
  listen '127.0.0.1:80'
	sitename 'localhost'
	docroot '/var/www/html'
	siteapps ['monitoring']
	enabled true
  only_if { node['cog_nginx']['install_monitoring_site'] == true}
end
