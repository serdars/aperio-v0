#
# Cookbook Name:: aperio
# Recipe:: base
#
# Copyright (C) 2014
#
#
#

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby "2.1.1" do
  action :install
  global true
end

rbenv_gem "bundler" do
  ruby_version "2.1.1"
end
