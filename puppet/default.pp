Exec {path => '/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:~/bin'}

class mirage-deps {
  $AMAZON_CERT_NAME = "Fill this in from cert-XXXX.pem and pk-XXXX.pem"
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
    path => '/home/vagrant/code/ec2/cert-${AMAZON_CERT_NAME}.pem',
    source => '/vagrant/puppet/cert-${AMAZON_CERT_NAME}.pem',
    owner => 'vagrant',
    group => 'vagrant'
  }

  file { 'amazon priv key':
    path => '/home/vagrant/code/ec2/pk-${AMAZON_CERT_NAME}.pem',
    source => '/vagrant/puppet/pk-${AMAZON_CERT_NAME}.pem',
    owner => 'vagrant',
    group => 'vagrant'
  }
}

include mirage-deps
