server '115.159.121.224', user: 'ricky', roles: %w{app web cache db}

set :ssh_options, {
    user: 'ricky', # overrides user setting above
    keys: %w(~/.ssh/id_rsa),
    port: 5022,
    forward_agent: false,
    auth_methods: %w(publickey password)
    # password: 'please use keys'
}

set :deploy_to, '/home/ricky/production/hike_cms'
set :branch, ENV.fetch('REVISION', ENV.fetch('BRANCH', 'production'))
set :rails_env, 'production'

# puma
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_env, fetch(:rails_env, 'production')
set :puma_threads, [0, 5]
set :puma_workers, 0

set :project_url, 'http://115.159.121.224:8090'
