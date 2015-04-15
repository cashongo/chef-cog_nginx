#
# Cookbook Name:: cog_nginx
# Provider:: site
#
# Author:: Lauri Jesmin <lauri.jesmin@cashongo.co.uk>
# Copyright 2015, Cash on Go
#
# In Chef 11 and above, calling the use_inline_resources method will
# make Chef create a new "run_context". When an action is called, any
# nested resources are compiled and converged in isolation from the
# recipe that calls it.

# Allow for Chef 10 support
use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create  do
  template "/etc/nginx/sites-available/#{new_resource.siteid}.conf" do
    action :create
    source 'nginx-site.conf.erb'
    cookbook 'cog_nginx'
    mode '0644'
    owner 'root'
    group 'root'
    variables ({
      :sitename => new_resource.sitename,
      :sitealiases => new_resource.sitealiases,
      :docroot => new_resource.docroot,
      :siteapps => new_resource.siteapps,
      :listen => new_resource.listen
      })
  end
  link "/etc/nginx/sites-enabled/#{new_resource.siteid}.conf" do
    to "../sites-available/#{new_resource.siteid}.conf"
    only_if { new_resource.enabled }
  end
end

action :delete do
  file "/etc/nginx/sites-enabled/#{new_resource.siteid}.conf" do
    action :delete
  end
  file "/etc/nginx/sites-available/#{new_resource.siteid}.conf" do
    action :delete
  end
end
