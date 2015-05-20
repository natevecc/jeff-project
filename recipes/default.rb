include_recipe "apt"
include_recipe "git"
include_recipe "vim"

# install nvm and node
include_recipe "nvm"
nvm_install "v0.12.3"  do
    from_source true
    alias_as_default true
    action :create
end

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