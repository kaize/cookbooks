#
# Cookbook Name:: yasm
# Recipe:: package
#
# Copyright 2012, Escape Studios
#

yasm_packages.each do |pkg|
	package pkg do
		action :upgrade
	end
end