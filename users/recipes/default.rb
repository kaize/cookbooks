#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#TODO handle errors
raise 'where is users?' if node[:users].empty?

gem_package 'ruby-shadow'

def create_user(login, ssh_keys = nil)
  user = data_bag_item('users', login)
  home = "/home/#{login}"
  user['password'] = `openssl passwd -1 #{user['password']}`.chomp if user['password']

  user(login) do
    gid       user["gid"] if user["gid"]
    shell     user['shell'] || '/bin/bash'
    comment   user['comment'] if user['comment']
    password  user['password'] if user['password']

    home      home
    supports  :manage_home => true
  end

  directory "#{home}/.ssh" do
    owner login
    group user["gid"] || login
    mode "0700"
  end

  template "#{home}/.ssh/authorized_keys" do
    source "authorized_keys.erb"
    owner login
    group user["gid"] || login
    mode "0600"
    variables :ssh_keys => ssh_keys || Array(user['ssh_keys'])
  end

end

node[:users].each do |login|
  if login.is_a? Hash
    ssh_keys = []
    login, linked_users = login.first

    data = data_bag_item('users', login)
    ssh_keys << data["ssh_keys"] if data["ssh_keys"]

    linked_users.each do |user|
      data = data_bag_item('users', user)
      ssh_keys << data["ssh_keys"] if data["ssh_keys"]
    end
  end

  create_user(login, ssh_keys)
end

