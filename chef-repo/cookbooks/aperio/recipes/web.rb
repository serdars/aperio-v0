#
# Cookbook Name:: aperio
# Recipe:: web
#
# Copyright (C) 2014
#
#
#

app = {
  :id => 'aperio',
  :group => 'aperio',
  :user => 'aperio'
}

include_recipe "nginx::default"

#
# NGINX REGISTRATION
#
#
template "#{node['nginx']['dir']}/sites-available/#{app[:id]}" do
  source "#{app[:id]}.conf.erb"
  owner app[:user]
  mode "0644"
  notifies :restart, resources(:service => app[:id]), :delayed
end

nginx_site app[:id]
