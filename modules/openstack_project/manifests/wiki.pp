# == Class: openstack_project::wiki
#
class openstack_project::wiki (
  $mysql_root_password = '',
  $sysadmins = [],
  $ssl_cert_file_contents = '',
  $ssl_key_file_contents = '',
  $ssl_chain_file_contents = '',
  $wg_dbpassword = undef,
  $wg_secretkey = undef,
  $wg_upgradekey = undef,
  $wg_captchaquestions_answer = undef,
  $wg_googleanalyticsaccount = undef,
) {

  package { ['openssl', 'ssl-cert', 'subversion']:
    ensure => present;
  }

  class { 'openstack_project::server':
    iptables_public_tcp_ports => [80, 443],
    sysadmins                 => $sysadmins,
  }

  realize (
    User::Virtual::Localuser['rlane'],
    User::Virtual::Localuser['mkiss'],
  )

  class { 'mediawiki':
    role                       => 'all',
    mediawiki_location         => '/srv/mediawiki/w',
    mediawiki_images_location  => '/srv/mediawiki/images',
    site_hostname              => $::fqdn,
    ssl_cert_file              => "/etc/ssl/certs/${::fqdn}.pem",
    ssl_key_file               => "/etc/ssl/private/${::fqdn}.key",
    ssl_chain_file             => '/etc/ssl/certs/intermediate.pem',
    ssl_cert_file_contents     => $ssl_cert_file_contents,
    ssl_key_file_contents      => $ssl_key_file_contents,
    ssl_chain_file_contents    => $ssl_chain_file_contents,
    wg_dbpassword              => $wg_dbpassword,
    wg_secretkey               => $wg_secretkey,
    wg_upgradekey              => $wg_upgradekey,
    wg_captchaquestions_answer => $wg_captchaquestions_answer,
    wg_googleanalyticsaccount  => $wg_googleanalyticsaccount,
  }
  class { 'memcached':
    max_memory => 2048,
    listen_ip  => '127.0.0.1',
    tcp_port   => 11000,
    udp_port   => 11000,
  }
  class { 'mysql::server':
    root_password    => $mysql_root_password,
    override_options => {
      'mysqld' => {
        'default-storage-engine' => 'InnoDB',
      }
    },
  }
  include mysql::server::account_security

  mysql_backup::backup { 'wiki':
    require => Class['mysql::server'],
  }

  include bup
  bup::site { 'rs-ord':
    backup_user   => 'bup-wiki',
    backup_server => 'ci-backup-rs-ord.openstack.org',
  }

  class { '::elasticsearch':
    es_template_config => {
      'bootstrap.mlockall'               => true,
      'discovery.zen.ping.unicast.hosts' => ['localhost'],
    },
    version            => '1.3.2',
    heap_size          => '1g',
  }

}
