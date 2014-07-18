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
  :group => 'aperio',
  :user => 'aperio',
  :git_repository => 'https://github.com/serdars/aperio.git'
}

#
# App deployment and configuration
#

include_recipe "runit"

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

shared_dirs = ["shared", "shared/system", "shared/config", "shared/pids", "shared/log"]
shared_dirs.each do |dir|
  directory "#{app[:deploy_to]}/#{dir}" do
    owner app[:user]
    group app[:group]
    mode '2775'
  end
end

#
# APP CONFIG
#

config_resources = [ ]
secrets = Chef::EncryptedDataBagItem.load("aperio", "secrets")

config_resources << template("#{app[:deploy_to]}/shared/config/secrets.yml") do
  source "secrets.yml.erb"
  owner app[:user]
  variables({
    secret_key_base: secrets["secret_key_base"]
  })
  mode "644"
end

#
# DEPLOY
#

config_resources << deploy_revision(app[:id]) do
  action :deploy

  revision node[:aperio][:version]
  repository app[:git_repository]

  symlink_before_migrate({})
  symlinks("system" => "public/system", "pids" => "tmp/pids", "log" => "log", "config/secrets.yml" => "config/secrets.yml")
  user app[:user]
  deploy_to app[:deploy_to]
  migrate true
  # Need pwd here as a workaround because otherwise Chef can't execute the command as a different user (facepalm)
  migration_command "pwd && RAILS_ENV=#{node[:aperio][:app_environment]} PATH=/opt/rbenv/shims:#{ENV['PATH']} bundle exec rake db:migrate --trace"
  before_migrate do
    execute "bundle install" do
      command "bundle install --deployment --without test development"
      environment "PATH" => "/opt/rbenv/shims:#{ENV['PATH']}"
      user app[:user]
      cwd release_path
    end
  end

  before_restart do
    execute "compile assets" do
      command "bundle exec rake assets:precompile"
      environment({
          "PATH" => "/opt/rbenv/shims:#{ENV['PATH']}",
          "RAILS_ENV" => node[:aperio][:app_environment]
        })
      user app[:user]
      cwd release_path
    end
  end
end

#
# UNICORN CONFIG
#

unicorn_config "/etc/unicorn/#{app[:id]}.rb" do
  listen "#{app[:deploy_to]}/current/tmp/#{app[:id]}.sock" => { :backlog => 64 }
  pid "#{app[:deploy_to]}/current/tmp/pids/unicorn.pid"
  stderr_path "#{app[:deploy_to]}/current/log/unicorn.stderr.log"
  stdout_path "#{app[:deploy_to]}/current/log/unicorn.stdout.log"
  working_directory "#{app[:deploy_to]}/current"
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
