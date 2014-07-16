#
# Cookbook Name:: aperio
# Recipe:: db
#
# Copyright (C) 2014
#
#
#

# Currently we are using only sqlite so just place the needed packages

["sqlite3", "libsqlite3-dev"].each do |p|
  package p
end
