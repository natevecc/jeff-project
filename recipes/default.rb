include_recipe "apt"
include_recipe "git"
include_recipe "vim"

# install nvm and node
node.default["nodejs"]["version"] = "0.12.2"
node.default['nodejs']['binary']['checksum']['linux_x64'] = '4e1578efc2a2cc67651413a05ccc4c5d43f6b4329c599901c556f24d93cd0508'
include_recipe "nodejs::nodejs_from_binary"
nodejs_npm "gulp"
nodejs_npm "coffee-script"

# install gulp

# install postgres and set up easy access for the dev environment
include_recipe "postgresql"
include_recipe "postgresql::server"
include_recipe "postgresql::config_initdb"

node.default["postgres"]["version"] = "9.4"
node.default['postgresql']['pg_hba'] = [
  {:comment => '# "local" is for Unix domain socket connections only', :type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'trust'},
  {:comment => '# IPv4 local connections:', :type => 'host', :db => 'all', :user => 'all', :addr => '0.0.0.0/0', :method => 'trust'},
  {:comment => '# IPv6 local connections:', :type => 'host', :db => 'all', :user => 'all', :addr => '::/0', :method => 'trust'}
]

# create default dev user
include_recipe "database::postgresql"
postgresql_connection_info = {
  :host => "127.0.0.1",
  :port => node['postgresql']['config']['port'],
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

postgresql_database_user 'jeff-dev' do
  connection postgresql_connection_info
  password 'dev'
  privileges [:all]
  action :create
end

postgresql_database 'nate_vecchiarelli' do
  connection(
    :host      => '127.0.0.1',
    :port      => node['postgresql']['config']['port'],
    :username  => 'postgres',
    :password  => node['postgresql']['password']['postgres']
  )
  action :create
  owner 'jeff-dev'
end