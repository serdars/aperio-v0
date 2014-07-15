#
# Cookbook Name:: aperio
# Recipe:: app
#
# Copyright (C) 2014
#
#
#

#
# Configurables
#

app = {
  :id => 'aperio',
  :deploy_to => '/srv/aperio',
  :port => 958,
  :group => 'aperio',
  :user => 'aperio',
  :git_repository => 'https://github.com/serdars/aperio.git'
}

#
# App deployment and configuration
#

include_recipe "runit"
rbenv_gem "unicorn"

user app[:user] do
  action :create
  comment "#{app[:id]} service user"
  system true
  shell '/bin/false'
  home "/srv/#{app[:user]}"
end

directory app[:deploy_to] do
  owner app[:user]
  group app[:group]
  mode '0755'
  recursive true
end

shared_dirs = ["shared", "shared/system", "shared/config", "shared/pids",
  "shared/log", "shared/vendor"]
shared_dirs.each do |dir|
  directory "#{app[:deploy_to]}/#{dir}" do
    owner app[:user]
    group app[:group]
    mode '2775'
  end
end

directory "#{app[:deploy_to]}/vendor" do
  owner app[:user]
  group app[:group]
  mode '0755'
end

#
# APP CONFIG
#

#
# FUTURE: Required config resources
#

config_resources = [ ]

# config_resources << template("#{app[:deploy_to]}/shared/config/database.yml") do
#   source "database.yml.erb"
#   owner app[:user]
#   mode "644"
#
#   notifies :restart, resources(:service => "nginx"), :delayed
# end

#
# DEPLOY
#

config_resources << deploy_revision(app[:id]) do
  action :deploy

  revision node[:aperio][:version]
  repository app[:git_repository]

  symlinks("system" => "public/system", "pids" => "tmp/pids", "log" => "log", "vendor" => "vendor")
  user app[:user]
  deploy_to app[:deploy_to]
  migrate true
  migration_command "RAILS_ENV=#{node[:aperio][:app_environment]} bundle exec rake db:migrate --trace"
  before_migrate do
    [
      ["bundle install", "bundle install --deployment --without test development"]
    ].each do |name, cmd|
      execute name do
        command cmd
        user app[:user]
        cwd release_path
      end
    end

  end

  before_restart do
    [
      ["compile assets", "bundle exec rake assets:precompile"]
    ].each do |name, cmd|
      execute name do
        command cmd
        user app[:user]
        cwd "#{app[:deploy_to]}/current"
      end
    end
  end
end

#
# UNICORN CONFIG
#

unicorn_config "/etc/unicorn/#{app[:id]}.rb" do
  listen "#{app[:deploy_to]}/current/tmp/#{app[:id]}.sock" => { :backlog => 64 }
  pid "#{app['deploy_to']}/current/tmp/pids/unicorn.pid"
  stderr_path "#{app['deploy_to']}/current/log/unicorn.stderr.log"
  stdout_path "#{app['deploy_to']}/current/log/unicorn.stdout.log"
  working_directory "#{app['deploy_to']}/current"
  worker_timeout 120
  preload_app true
  worker_processes 2
  owner app[:user]
end

runit_service app[:id] do
  template_name 'unicorn'
  owner app[:user]
  run_template_name 'unicorn'
  log_template_name 'unicorn'

  cookbook 'aperio'
  options(
          :app => app,
          :rails_env => node[:aperio][:app_environment],
          :smells_like_rack => ::File.exists?(::File.join(app[:deploy_to], "current", "config.ru"))
          )
end

app_service = resources(:service => app[:id])
config_resources.each {|res| app_service.subscribes :restart, res}
