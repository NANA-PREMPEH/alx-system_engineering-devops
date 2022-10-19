# Practice configuring a server with Puppet! Just as you did before, 
# install and configure an Nginx server using Puppet instead of Bash. To save time and effort, include resources in 
# the manifest to perform a 301 redirect when querying /redirect_me.
# Manifest to configure an Ubuntu server with nginx

# Install nginx
package { 'nginx':
  ensure   => present,
  provider => 'apt'
}
#Added a file index-.html
file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!'
}

#Redirect to another file
file_line { 'Redirection':
  ensure => present,
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => '        rewrite ^/redirect_me https://www.youtube.com/watch?v=dQw4w9WgXcQ permanent;'
}

# Restart service
service { 'nginx':
  ensure     => running,
  enable     => true,
  require    => Package['nginx'],
  subscribe  => File_line['Redirection']
}
