#
# Cookbook Name:: mysqlbackup
# Recipe:: default
#
# Copyright 2014, handwerk*neu
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

version = node['mysqlbackup']['version']

# Download .tar.gz from Google Code
remote_file "#{Chef::Config[:file_cache_path]}/mysqlbackup-#{version}.tar.gz" do
  source "https://mysqlbackup.googlecode.com/files/mysqlbackup-#{version}.tar.gz"
end

# Extract archive and copy files to appropriate directories
bash 'install-mysqlbackup' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar xzf mysqlbackup-#{version}.tar.gz
    mkdir -p /usr/local/share/man/man1
    mv mysqlbackup-#{version}/mysqlbackup /usr/local/bin
    mv mysqlbackup-#{version}/mysqlbackup.1 /usr/local/share/man/man1/
  EOH
end

# Create backup directory
directory '/var/backups' do
  owner node['mysqlbackup']['user']
  group node['mysqlbackup']['group']
  mode '0700'
end

# Change shell for backup system user
execute 'change-shell' do
  command "chsh -s /bin/bash #{node['mysqlbackup']['user']}"
end

# Create MySQL account if enabled
if node['mysqlbackup']['enable_mysql']
  mysql_database_user node['mysqlbackup']['mysql_user'] do
    connection {
      host: 'localhost',
      username: 'root',
      password: node['mysql']['server_root_password']
    }
    password node['mysqlbackup']['mysql_password']
    database_name '*.*'
    privileges [:select, :insert, :'lock tables', :event]
    action :grant
  end

  template '/var/backups/.my.cnf' do
    source 'my.cnf.erb'
    owner node['mysqlbackup']['user']
    group node['mysqlbackup']['group']
    mode '0600'
  end
end

# Create duply pre backup script if enabled
if node['mysqlbackup']['enable_duply']
  template '/etc/duply/main/pre' do
    source 'duply_pre'
    mode '0755'
  end
end