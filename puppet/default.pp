Exec {path => '/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:~/bin'}

class mirage-deps {
  $amazon_cert_name = "HJPQTUP5HACKEDCFJN2B5JCABCVOP4LY"

  exec { "apt-get update":
      command => "/usr/bin/apt-get update",
      onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
  }

  package { [
    "build-essential",
    "ocaml",
    "ocaml-native-compilers",
    "camlp4-extra",
    "git",
    "curl",
    "m4",
    "ec2-api-tools",
    "ec2-ami-tools",
    "s3cmd",
    "vim"
  ]:
    ensure => present,
    require => Exec['apt-get update'],
  }

  file {
    [
      "/home/vagrant/bin",
      "/home/vagrant/code",
      "/home/vagrant/code/ec2",
    ]:
    ensure => directory,
    owner => 'vagrant',
    group => 'vagrant'
  }

  file { 'make_ec2.sh':
    path => '/home/vagrant/bin/make_ec2.sh',
    source => '/vagrant/puppet/make_ec2.sh',
    mode => 0700,
    owner => 'vagrant',
    group => 'vagrant'
  }

  file { 'amazon cert':
    path => "/home/vagrant/code/ec2/cert-${amazon_cert_name}.pem",
    source => "/vagrant/puppet/cert-${amazon_cert_name}.pem",
    owner => 'vagrant',
    group => 'vagrant'
  }

  file { 'amazon priv key':
    path => "/home/vagrant/code/ec2/pk-${amazon_cert_name}.pem",
    source => "/vagrant/puppet/pk-${amazon_cert_name}.pem",
    owner => 'vagrant',
    group => 'vagrant'
  }
}

include mirage-deps
