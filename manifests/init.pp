class tomcat {

  require wget

  file { '/opt/tomcat':
    ensure => present,
    alias  => 'opt-tomcat'
  }

  exec { 'fetch-tomcat':
    cwd     => '/tmp',
    command => 'wget http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.41/bin/apache-tomcat-7.0.41.tar.gz',
    creates => '/tmp/apache-tomcat-7.0.41.tar.gz',
    path    => ['/opt/boxen/homebrew/bin'],
    alias   => 'fetch-tomcat',
    require => File['opt-tomcat']
  }

  exec { 'extract-tomcat':
    cwd         => '/opt/tomcat',
    command     => 'tar xvf /tmp/apache-tomcat-7.0.41.tar.gz',
    creates     => '/opt/tomcat/apache-tomcat-7.0.41',
    path        => ['/usr/bin'],
    refreshonly => true,
    subscribe   => Exec['fetch-tomcat'],
    alias       => 'extract-tomcat'
  }
  
  file { '/opt/tomcat/current': 
    ensure  => link,
    target  => '/opt/tomcat/apache-tomcat-7.0.41',
    require => Exec['extract-tomcat']
  }

}
