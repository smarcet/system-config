#
# Top-level variables
#
# There must not be any whitespace between this comment and the variables or
# in between any two variables in order for them to be correctly parsed and
# passed around in test.sh
#
$elasticsearch_nodes = [
  'elasticsearch02.openstack.org',
  'elasticsearch03.openstack.org',
  'elasticsearch04.openstack.org',
  'elasticsearch05.openstack.org',
  'elasticsearch06.openstack.org',
  'elasticsearch07.openstack.org',
]
$elasticsearch_clients = [
  'logstash.openstack.org',
  'logstash-worker01.openstack.org',
  'logstash-worker02.openstack.org',
  'logstash-worker03.openstack.org',
  'logstash-worker04.openstack.org',
  'logstash-worker05.openstack.org',
  'logstash-worker06.openstack.org',
  'logstash-worker07.openstack.org',
  'logstash-worker08.openstack.org',
  'logstash-worker09.openstack.org',
  'logstash-worker10.openstack.org',
  'logstash-worker11.openstack.org',
  'logstash-worker12.openstack.org',
  'logstash-worker13.openstack.org',
  'logstash-worker14.openstack.org',
  'logstash-worker15.openstack.org',
  'logstash-worker16.openstack.org',
  'logstash-worker17.openstack.org',
  'logstash-worker18.openstack.org',
  'logstash-worker19.openstack.org',
  'logstash-worker20.openstack.org',
  'subunit-worker01.openstack.org',
]

#
# Default: should at least behave like an openstack server
#
node default {
  class { 'openstack_project::server':
    sysadmins => hiera('sysadmins', []),
  }
}

#
# Long lived servers:
#
# Node-OS: precise
# Node-OS: trusty
node 'review.openstack.org' {
  class { 'openstack_project::review':
    project_config_repo                 => 'https://git.openstack.org/openstack-infra/project-config',
    github_oauth_token                  => hiera('gerrit_github_token'),
    github_project_username             => hiera('github_project_username', 'username'),
    github_project_password             => hiera('github_project_password'),
    mysql_host                          => hiera('gerrit_mysql_host', 'localhost'),
    mysql_password                      => hiera('gerrit_mysql_password'),
    email_private_key                   => hiera('gerrit_email_private_key'),
    token_private_key                   => hiera('gerrit_rest_token_private_key'),
    gerritbot_password                  => hiera('gerrit_gerritbot_password'),
    gerritbot_ssh_rsa_key_contents      => hiera('gerritbot_ssh_rsa_key_contents'),
    gerritbot_ssh_rsa_pubkey_contents   => hiera('gerritbot_ssh_rsa_pubkey_contents'),
    ssl_cert_file_contents              => hiera('gerrit_ssl_cert_file_contents'),
    ssl_key_file_contents               => hiera('gerrit_ssl_key_file_contents'),
    ssl_chain_file_contents             => hiera('gerrit_ssl_chain_file_contents'),
    ssh_dsa_key_contents                => hiera('gerrit_ssh_dsa_key_contents'),
    ssh_dsa_pubkey_contents             => hiera('gerrit_ssh_dsa_pubkey_contents'),
    ssh_rsa_key_contents                => hiera('gerrit_ssh_rsa_key_contents'),
    ssh_rsa_pubkey_contents             => hiera('gerrit_ssh_rsa_pubkey_contents'),
    ssh_project_rsa_key_contents        => hiera('gerrit_project_ssh_rsa_key_contents'),
    ssh_project_rsa_pubkey_contents     => hiera('gerrit_project_ssh_rsa_pubkey_contents'),
    ssh_welcome_rsa_key_contents        => hiera('welcome_message_gerrit_ssh_private_key'),
    ssh_welcome_rsa_pubkey_contents     => hiera('welcome_message_gerrit_ssh_public_key'),
    ssh_replication_rsa_key_contents    => hiera('gerrit_replication_ssh_rsa_key_contents'),
    ssh_replication_rsa_pubkey_contents => hiera('gerrit_replication_ssh_rsa_pubkey_contents'),
    lp_sync_consumer_key                => hiera('gerrit_lp_consumer_key'),
    lp_sync_token                       => hiera('gerrit_lp_access_token'),
    lp_sync_secret                      => hiera('gerrit_lp_access_secret'),
    contactstore_appsec                 => hiera('gerrit_contactstore_appsec'),
    contactstore_pubkey                 => hiera('gerrit_contactstore_pubkey'),
    sysadmins                           => hiera('sysadmins', []),
    swift_username                      => hiera('swift_store_user', 'username'),
    swift_password                      => hiera('swift_store_key'),
  }
}

# Node-OS: trusty
node 'review-dev.openstack.org' {
  class { 'openstack_project::review_dev':
    project_config_repo                 => 'https://git.openstack.org/openstack-infra/project-config',
    github_oauth_token                  => hiera('gerrit_dev_github_token'),
    github_project_username             => hiera('github_dev_project_username', 'username'),
    github_project_password             => hiera('github_dev_project_password'),
    mysql_host                          => hiera('gerrit_dev_mysql_host', 'localhost'),
    mysql_password                      => hiera('gerrit_dev_mysql_password'),
    email_private_key                   => hiera('gerrit_dev_email_private_key'),
    contactstore_appsec                 => hiera('gerrit_dev_contactstore_appsec'),
    contactstore_pubkey                 => hiera('gerrit_dev_contactstore_pubkey'),
    ssh_dsa_key_contents                => hiera('gerrit_dev_ssh_dsa_key_contents'),
    ssh_dsa_pubkey_contents             => hiera('gerrit_dev_ssh_dsa_pubkey_contents'),
    ssh_rsa_key_contents                => hiera('gerrit_dev_ssh_rsa_key_contents'),
    ssh_rsa_pubkey_contents             => hiera('gerrit_dev_ssh_rsa_pubkey_contents'),
    ssh_project_rsa_key_contents        => hiera('gerrit_dev_project_ssh_rsa_key_contents'),
    ssh_project_rsa_pubkey_contents     => hiera('gerrit_dev_project_ssh_rsa_pubkey_contents'),
    ssh_replication_rsa_key_contents    => hiera('gerrit_dev_replication_ssh_rsa_key_contents'),
    ssh_replication_rsa_pubkey_contents => hiera('gerrit_dev_replication_ssh_rsa_pubkey_contents'),
    lp_sync_consumer_key                => hiera('gerrit_dev_lp_consumer_key'),
    lp_sync_token                       => hiera('gerrit_dev_lp_access_token'),
    lp_sync_secret                      => hiera('gerrit_dev_lp_access_secret'),
    sysadmins                           => hiera('sysadmins', []),
  }
}

# Node-OS: trusty
node 'grafana.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [80],
    sysadmins                 => hiera('sysadmins', []),
  }
  class { 'openstack_project::grafana':
    admin_password      => hiera('grafana_admin_password', 'XXX'),
    admin_user          => hiera('grafana_admin_user', 'username'),
    mysql_host          => hiera('grafana_mysql_host', 'localhost'),
    mysql_name          => hiera('grafana_mysql_name', 'XXX'),
    mysql_password      => hiera('grafana_mysql_password', 'XXX'),
    mysql_user          => hiera('grafana_mysql_user', 'username'),
    project_config_repo => 'https://git.openstack.org/openstack-infra/project-config',
    secret_key          => hiera('grafana_secret_key', 'XXX'),
  }
}

# Node-OS: trusty
node 'health.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [80, 443],
    sysadmins                 => hiera('sysadmins', []),
  }
  class { 'openstack_project::openstack_health_api':
    subunit2sql_db_host => hiera('subunit2sql_db_host', 'localhost'),
  }
}


# Node-OS: precise
node 'jenkins.openstack.org' {
  $group = "jenkins"
  $zmq_event_receivers = ['logstash.openstack.org',
                          'nodepool.openstack.org']
  $iptables_rule = regsubst ($zmq_event_receivers,
                             '^(.*)$', '-m state --state NEW -m tcp -p tcp --dport 8888 -s \1 -j ACCEPT')
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [80, 443],
    iptables_rules6           => $iptables_rule,
    iptables_rules4           => $iptables_rule,
    sysadmins                 => hiera('sysadmins', []),
    puppetmaster_server       => 'puppetmaster.openstack.org',
  }
  class { 'openstack_project::jenkins':
    project_config_repo     => 'https://git.openstack.org/openstack-infra/project-config',
    jenkins_password        => hiera('jenkins_jobs_password', 'XXX'),
    jenkins_ssh_private_key => hiera('jenkins_ssh_private_key_contents', 'XXX'),
    ssl_cert_file           => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
    ssl_key_file            => '/etc/ssl/private/ssl-cert-snakeoil.key',
    ssl_chain_file          => '',
  }
}

# Node-OS: precise
node /^jenkins\d+\.openstack\.org$/ {
  $group = "jenkins"
  $zmq_event_receivers = ['logstash.openstack.org',
                          'nodepool.openstack.org']
  $iptables_rule = regsubst ($zmq_event_receivers,
                             '^(.*)$', '-m state --state NEW -m tcp -p tcp --dport 8888 -s \1 -j ACCEPT')
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [80, 443],
    iptables_rules6           => $iptables_rule,
    iptables_rules4           => $iptables_rule,
    sysadmins                 => hiera('sysadmins', []),
    puppetmaster_server       => 'puppetmaster.openstack.org',
  }
  class { 'openstack_project::jenkins':
    jenkins_password        => hiera('jenkins_jobs_password', 'XXX'),
    jenkins_ssh_private_key => hiera('jenkins_ssh_private_key_contents', 'XXX'),
    ssl_cert_file           => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
    ssl_key_file            => '/etc/ssl/private/ssl-cert-snakeoil.key',
    ssl_chain_file          => '',
  }
}

# Node-OS: precise
node 'jenkins-dev.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [80, 443],
    sysadmins                 => hiera('sysadmins', []),
    puppetmaster_server       => 'puppetmaster.openstack.org',
  }
  class { 'openstack_project::jenkins_dev':
    jenkins_ssh_private_key  => hiera('jenkins_dev_ssh_private_key_contents', 'XXX'),
    mysql_password           => hiera('nodepool_dev_mysql_password', 'XXX'),
    mysql_root_password      => hiera('nodepool_dev_mysql_root_password', 'XXX'),
    nodepool_ssh_private_key => hiera('jenkins_dev_ssh_private_key_contents', 'XXX'),
    jenkins_api_user         => hiera('jenkins_dev_api_user', 'username'),
    jenkins_api_key          => hiera('jenkins_dev_api_key', 'XXX'),
    jenkins_credentials_id   => hiera('jenkins_dev_credentials_id', 'XXX'),
    hpcloud_username         => hiera('nodepool_hpcloud_username', 'username'),
    hpcloud_password         => hiera('nodepool_hpcloud_password', 'XXX'),
    hpcloud_project          => hiera('nodepool_hpcloud_project', 'XXX'),
  }
}

# Node-OS: precise
node 'cacti.openstack.org' {
  include openstack_project::ssl_cert_check
  class { 'openstack_project::cacti':
    sysadmins => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'puppetmaster.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [4505, 4506, 8140],
    sysadmins                 => hiera('sysadmins', []),
    pin_puppet                => '3.6.',
  }
  class { 'openstack_project::puppetmaster':
    root_rsa_key     => hiera('puppetmaster_root_rsa_key', 'XXX'),
    jenkins_api_user => hiera('jenkins_api_user', 'username'),
    jenkins_api_key  => hiera('jenkins_api_key', 'XXX'),
  }
}

# Node-OS: precise
node 'puppetdb.openstack.org' {
  class { 'openstack_project::puppetdb':
    sysadmins => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'graphite.openstack.org' {
  $statsd_hosts = ['logstash.openstack.org',
                   'nodepool.openstack.org',
                   'zuul.openstack.org']

  # Turn a list of hostnames into a list of iptables rules
  $rules = regsubst ($statsd_hosts, '^(.*)$', '-m udp -p udp -s \1 --dport 8125 -j ACCEPT')

  class { 'openstack_project::server':
    iptables_public_tcp_ports => [80, 443],
    iptables_rules6           => $rules,
    iptables_rules4           => $rules,
    sysadmins                 => hiera('sysadmins', [])
  }

  class { '::graphite':
    graphite_admin_user     => hiera('graphite_admin_user', 'username'),
    graphite_admin_email    => hiera('graphite_admin_email', 'email@example.com'),
    graphite_admin_password => hiera('graphite_admin_password', 'XXX'),
  }
}

# Node-OS: precise
node 'groups.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [22, 80, 443],
    sysadmins                 => hiera('sysadmins', []),
  }
  class { 'openstack_project::groups':
    site_admin_password          => hiera('groups_site_admin_password', 'XXX'),
    site_mysql_host              => hiera('groups_site_mysql_host', 'localhost'),
    site_mysql_password          => hiera('groups_site_mysql_password', 'XXX'),
    conf_cron_key                => hiera('groups_conf_cron_key', 'XXX'),
    site_ssl_cert_file_contents  => hiera('groups_site_ssl_cert_file_contents', undef),
    site_ssl_key_file_contents   => hiera('groups_site_ssl_key_file_contents', undef),
    site_ssl_chain_file_contents => hiera('groups_site_ssl_chain_file_contents', undef),
  }
}

# Node-OS: precise
node 'groups-dev.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [22, 80, 443],
    sysadmins                 => hiera('sysadmins', []),
  }
  class { 'openstack_project::groups_dev':
    site_admin_password          => hiera('groups_dev_site_admin_password', 'XXX'),
    site_mysql_host              => hiera('groups_dev_site_mysql_host', 'localhost'),
    site_mysql_password          => hiera('groups_dev_site_mysql_password', 'XXX'),
    conf_cron_key                => hiera('groups_dev_conf_cron_key', 'XXX'),
    site_ssl_cert_file_contents  => hiera('groups_dev_site_ssl_cert_file_contents', undef),
    site_ssl_key_file_contents   => hiera('groups_dev_site_ssl_key_file_contents', undef),
    site_ssl_cert_file           => '/etc/ssl/certs/groups-dev.openstack.org.pem',
    site_ssl_key_file            => '/etc/ssl/private/groups-dev.openstack.org.key',
  }
}

# Node-OS: precise
node 'lists.openstack.org' {
  class { 'openstack_project::lists':
    listadmins   => hiera('listadmins', []),
    listpassword => hiera('listpassword', 'XXX'),
  }
}

# Node-OS: precise
node 'paste.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [80],
    sysadmins                 => hiera('sysadmins', []),
  }
  class { 'openstack_project::paste':
    db_password         => hiera('paste_db_password', 'XXX'),
    mysql_root_password => hiera('paste_mysql_root_password', 'XXX'),
  }
}

# Node-OS: precise
node 'planet.openstack.org' {
  class { 'openstack_project::planet':
    sysadmins => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'eavesdrop.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [80],
    sysadmins                 => hiera('sysadmins', []),
  }

  class { 'openstack_project::eavesdrop':
    project_config_repo     => 'https://git.openstack.org/openstack-infra/project-config',
    nickpass                => hiera('openstack_meetbot_password', 'XXX'),
    statusbot_nick          => hiera('statusbot_nick', 'username'),
    statusbot_password      => hiera('statusbot_nick_password', 'XXX'),
    statusbot_server        => 'chat.freenode.net',
    statusbot_channels      => 'edeploy, fuel-dev, heat, kolla, murano, openstack, openstack-101, openstack-ansible, openstack-anvil, openstack-bacon, openstack-barbican, openstack-blazar, openstack-board, openstack-ceilometer, openstack-chef, openstack-cinder, openstack-cloudkeep, openstack-community, openstack-containers, openstack-defcore, openstack-dev, openstack-dns, openstack-doc, openstack-entropy, openstack-foundation, openstack-gantt, openstack-gate, openstack-glance, openstack-heat-translator, openstack-horizon, openstack-hyper-v, openstack-i18n, openstack-infra, openstack-infra-incident, openstack-ironic, openstack-keystone, openstack-manila, openstack-meeting, openstack-meeting-3, openstack-meeting-4, openstack-meeting-alt, openstack-meniscus, openstack-merges, openstack-metering, openstack-monasca, openstack-neutron, openstack-nova, openstack-opw, openstack-oslo, openstack-qa, openstack-raksha, openstack-rally, openstack-rating, openstack-relmgr-office, openstack-sahara, openstack-sdks, openstack-sprint, openstack-stable, openstack-state-management, openstack-swift, openstack-trove, openstack-zaqar, packstack-dev, refstack, storyboard, syscompass, tripleo',
    statusbot_auth_nicks    => 'jeblair, ttx, fungi, mordred, clarkb, sdague, SergeyLukjanov, jhesketh, lifeless, pleia2',
    statusbot_wiki_user     => hiera('statusbot_wiki_username', 'username'),
    statusbot_wiki_password => hiera('statusbot_wiki_password', 'XXX'),
    statusbot_wiki_url      => 'https://wiki.openstack.org/w/api.php',
    # https://wiki.openstack.org/wiki/Infrastructure_Status
    statusbot_wiki_pageid   => '1781',
    # https://wiki.openstack.org/wiki/Successes
    statusbot_wiki_successpageid => '7717',
    statusbot_irclogs_url   => 'http://eavesdrop.openstack.org/irclogs/%(chan)s/%(chan)s.%(date)s.log.html',
    accessbot_nick          => hiera('accessbot_nick', 'username'),
    accessbot_password      => hiera('accessbot_nick_password', 'XXX'),
  }
}

# Node-OS: trusty
node 'etherpad.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [22, 80, 443],
    sysadmins                 => hiera('sysadmins', []),
  }

  class { 'openstack_project::etherpad':
    ssl_cert_file_contents  => hiera('etherpad_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('etherpad_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('etherpad_ssl_chain_file_contents', 'XXX'),
    mysql_host              => hiera('etherpad_db_host', 'localhost'),
    mysql_user              => hiera('etherpad_db_user', 'username'),
    mysql_password          => hiera('etherpad_db_password', 'XXX'),
  }
}

# Node-OS: trusty
node 'etherpad-dev.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [22, 80, 443],
    sysadmins                 => hiera('sysadmins', []),
  }

  class { 'openstack_project::etherpad_dev':
    mysql_host          => hiera('etherpad-dev_db_host', 'localhost'),
    mysql_user          => hiera('etherpad-dev_db_user', 'username'),
    mysql_password      => hiera('etherpad-dev_db_password', 'XXX'),
  }
}

# Node-OS: precise
node 'wiki.openstack.org' {
  class { 'openstack_project::wiki':
    mysql_root_password     => hiera('wiki_db_password', 'XXX'),
    sysadmins               => hiera('sysadmins', []),
    ssl_cert_file_contents  => hiera('wiki_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('wiki_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('wiki_ssl_chain_file_contents', 'XXX'),
  }
}

# Node-OS: precise
node 'logstash.openstack.org' {
  $iptables_es_rule = regsubst($elasticsearch_nodes,
  '^(.*)$', '-m state --state NEW -m tcp -p tcp --dport 9200:9400 -s \1 -j ACCEPT')
  $iptables_gm_rule = regsubst($elasticsearch_clients,
  '^(.*)$', '-m state --state NEW -m tcp -p tcp --dport 4730 -s \1 -j ACCEPT')
  $logstash_iptables_rule = flatten([$iptables_es_rule, $iptables_gm_rule])

  class { 'openstack_project::server':
    iptables_public_tcp_ports => [22, 80, 3306],
    iptables_rules6           => $logstash_iptables_rule,
    iptables_rules4           => $logstash_iptables_rule,
    sysadmins                 => hiera('sysadmins', []),
  }

  class { 'openstack_project::logstash':
    discover_nodes      => [
      'elasticsearch02.openstack.org:9200',
      'elasticsearch03.openstack.org:9200',
      'elasticsearch04.openstack.org:9200',
      'elasticsearch05.openstack.org:9200',
      'elasticsearch06.openstack.org:9200',
      'elasticsearch07.openstack.org:9200',
    ],
    subunit2sql_db_host => hiera('subunit2sql_db_host', ''),
    subunit2sql_db_pass => hiera('subunit2sql_db_password', ''),
  }
}

# Node-OS: precise
node /^logstash-worker\d+\.openstack\.org$/ {
  $logstash_worker_iptables_rule = regsubst(flatten([$elasticsearch_nodes, $elasticsearch_clients]),
  '^(.*)$', '-m state --state NEW -m tcp -p tcp --dport 9200:9400 -s \1 -j ACCEPT')
  $group = 'logstash-worker'

  class { 'openstack_project::server':
    iptables_public_tcp_ports => [22],
    iptables_rules6           => $logstash_worker_iptables_rule,
    iptables_rules4           => $logstash_worker_iptables_rule,
    sysadmins                 => hiera('sysadmins', []),
  }

  class { 'openstack_project::logstash_worker':
    discover_node         => 'elasticsearch02.openstack.org',
  }
}

# Node-OS: trusty
node /^subunit-worker\d+\.openstack\.org$/ {
  $group = "subunit-worker"
  class { 'openstack_project::subunit_worker':
    sysadmins           => hiera('sysadmins', []),
    subunit2sql_db_host => hiera('subunit2sql_db_host', ''),
    subunit2sql_db_pass => hiera('subunit2sql_db_password', ''),
  }
}

# Node-OS: precise
node /^elasticsearch0[1-7]\.openstack\.org$/ {
  $group = "elasticsearch"
  class { 'openstack_project::elasticsearch_node':
    sysadmins             => hiera('sysadmins', []),
    elasticsearch_nodes   => $elasticsearch_nodes,
    elasticsearch_clients => $elasticsearch_clients,
    discover_nodes        => $elasticsearch_nodes,
  }
}

# CentOS machines to load balance git access.
# Node-OS: centos6
node /^git(-fe\d+)?\.openstack\.org$/ {
  $group = "git-loadbalancer"
  class { 'openstack_project::git':
    sysadmins               => hiera('sysadmins', []),
    balancer_member_names   => [
      'git01.openstack.org',
      'git02.openstack.org',
      'git03.openstack.org',
      'git04.openstack.org',
      'git05.openstack.org',
      'git06.openstack.org',
      'git07.openstack.org',
      'git08.openstack.org',
    ],
    balancer_member_ips     => [
      '104.130.243.237',
      '104.130.243.109',
      '67.192.247.197',
      '67.192.247.180',
      '23.253.69.135',
      '104.239.132.223',
      '23.253.94.84',
      '104.239.146.131',
    ],
  }
}

# CentOS machines to run cgit and git daemon. Will be
# load balanced by git.openstack.org.
# Node-OS: centos7
node /^git\d+\.openstack\.org$/ {
  $group = "git-server"
  include openstack_project
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [4443, 8080, 29418],
    sysadmins                 => hiera('sysadmins', []),
  }

  class { 'openstack_project::git_backend':
    project_config_repo     => 'https://git.openstack.org/openstack-infra/project-config',
    vhost_name              => 'git.openstack.org',
    git_gerrit_ssh_key      => hiera('gerrit_replication_ssh_rsa_pubkey_contents', 'XXX'),
    ssl_cert_file_contents  => hiera('git_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('git_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('git_ssl_chain_file_contents', 'XXX'),
    behind_proxy            => true,
  }
}

# Machines in each region to run PyPI mirrors.
# Node-OS: precise
node /^pypi\..*\.openstack\.org$/ {
  $group = "pypi"
  class { 'openstack_project::pypi':
    sysadmins               => hiera('sysadmins', []),
  }
}

# A machine to run ODSREG in preparation for summits.
# Node-OS: trusty
node 'design-summit-prep.openstack.org' {
  class { 'openstack_project::summit':
    sysadmins => hiera('sysadmins', []),
  }
}

# Node-OS: trusty
node 'refstack.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [80, 443],
    sysadmins                 => hiera('sysadmins', []),
  }
  class { 'refstack':
    mysql_host          => hiera('refstack_mysql_host', 'localhost'),
    mysql_database      => hiera('refstack_mysql_db_name', 'refstack'),
    mysql_user          => hiera('refstack_mysql_user', 'refstack'),
    mysql_user_password => hiera('refstack_mysql_password', 'XXX'),
    ssl_cert_content    => hiera('refstack_ssl_cert_file_contents', 'XXX'),
    ssl_key_content     => hiera('refstack_ssl_key_file_contents', 'XXX'),
    ssl_ca_content      => hiera('refstack_ssl_chain_file_contents', 'XXX'),
    protocol            => 'https',
  }
}

# A machine to run Storyboard
# Node-OS: precise
node 'storyboard.openstack.org' {
  class { 'openstack_project::storyboard':
    project_config_repo     => 'https://git.openstack.org/openstack-infra/project-config',
    sysadmins               => hiera('sysadmins', []),
    mysql_host              => hiera('storyboard_db_host', 'localhost'),
    mysql_user              => hiera('storyboard_db_user', 'username'),
    mysql_password          => hiera('storyboard_db_password', 'XXX'),
    rabbitmq_user           => hiera('storyboard_rabbit_user', 'username'),
    rabbitmq_password       => hiera('storyboard_rabbit_password', 'XXX'),
    ssl_cert_file_contents  => hiera('storyboard_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('storyboard_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('storyboard_ssl_chain_file_contents', 'XXX'),
    hostname                => $::fqdn,
    valid_oauth_clients     => [
      $::fqdn,
      'docs-draft.openstack.org',
    ],
    cors_allowed_origins     => [
      "https://${::fqdn}",
      'http://docs-draft.openstack.org',
    ],
  }
}

# A machine to serve static content.
# Node-OS: precise
node 'static.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [22, 80, 443],
    sysadmins                 => hiera('sysadmins', []),
  }
  class { 'openstack_project::static':
    project_config_repo     => 'https://git.openstack.org/openstack-infra/project-config',
    swift_authurl           => 'https://identity.api.rackspacecloud.com/v2.0/',
    swift_user              => 'infra-files-ro',
    swift_key               => hiera('infra_files_ro_password', 'XXX'),
    swift_tenant_name       => hiera('infra_files_tenant_name', 'tenantname'),
    swift_region_name       => 'DFW',
    swift_default_container => 'infra-files',
    ssl_cert_file_contents  => hiera('static_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('static_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('static_ssl_chain_file_contents', 'XXX'),
  }
}

# A machine to serve various project status updates.
# Node-OS: precise
node 'status.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [22, 80, 443],
    sysadmins                 => hiera('sysadmins', []),
  }

  class { 'openstack_project::status':
    gerrit_host                   => 'review.openstack.org',
    gerrit_ssh_host_key           => hiera('gerrit_ssh_rsa_pubkey_contents', 'XXX'),
    reviewday_ssh_public_key      => hiera('reviewday_rsa_pubkey_contents', 'XXX'),
    reviewday_ssh_private_key     => hiera('reviewday_rsa_key_contents', 'XXX'),
    releasestatus_ssh_public_key  => hiera('releasestatus_rsa_pubkey_contents', 'XXX'),
    releasestatus_ssh_private_key => hiera('releasestatus_rsa_key_contents', 'XXX'),
    recheck_ssh_public_key        => hiera('elastic-recheck_gerrit_ssh_public_key', 'XXX'),
    recheck_ssh_private_key       => hiera('elastic-recheck_gerrit_ssh_private_key', 'XXX'),
    recheck_bot_nick              => 'openstackrecheck',
    recheck_bot_passwd            => hiera('elastic-recheck_ircbot_password', 'XXX'),
  }
}

# Node-OS: trusty
node 'nodepool.openstack.org' {
  class { 'openstack_project::server':
    sysadmins                 => hiera('sysadmins', []),
    iptables_public_tcp_ports => [80],
  }

  class { 'openstack_project::nodepool_prod':
    project_config_repo      => 'https://git.openstack.org/openstack-infra/project-config',
    mysql_password           => hiera('nodepool_mysql_password', 'XXX'),
    mysql_root_password      => hiera('nodepool_mysql_root_password', 'XXX'),
    nodepool_ssh_private_key => hiera('jenkins_ssh_private_key_contents', 'XXX'),
    statsd_host              => 'graphite.openstack.org',
    jenkins_masters          => [
      {
        name        => 'jenkins01',
        url         => 'https://jenkins01.openstack.org/',
        user        => hiera('jenkins_api_user', 'username'),
        apikey      => hiera('jenkins_api_key', 'XXX'),
        credentials => hiera('jenkins_credentials_id', 'XXX'),
      },
      {
        name        => 'jenkins02',
        url         => 'https://jenkins02.openstack.org/',
        user        => hiera('jenkins_api_user', 'username'),
        apikey      => hiera('jenkins_api_key', 'XXX'),
        credentials => hiera('jenkins_credentials_id', 'XXX'),
      },
      {
        name        => 'jenkins03',
        url         => 'https://jenkins03.openstack.org/',
        user        => hiera('jenkins_api_user', 'username'),
        apikey      => hiera('jenkins_api_key', 'XXX'),
        credentials => hiera('jenkins_credentials_id', 'XXX'),
      },
      {
        name        => 'jenkins04',
        url         => 'https://jenkins04.openstack.org/',
        user        => hiera('jenkins_api_user', 'username'),
        apikey      => hiera('jenkins_api_key', 'XXX'),
        credentials => hiera('jenkins_credentials_id', 'XXX'),
      },
      {
        name        => 'jenkins05',
        url         => 'https://jenkins05.openstack.org/',
        user        => hiera('jenkins_api_user', 'username'),
        apikey      => hiera('jenkins_api_key', 'XXX'),
        credentials => hiera('jenkins_credentials_id', 'XXX'),
      },
      {
        name        => 'jenkins06',
        url         => 'https://jenkins06.openstack.org/',
        user        => hiera('jenkins_api_user', 'username'),
        apikey      => hiera('jenkins_api_key', 'XXX'),
        credentials => hiera('jenkins_credentials_id', 'XXX'),
      },
      {
        name        => 'jenkins07',
        url         => 'https://jenkins07.openstack.org/',
        user        => hiera('jenkins_api_user', 'username'),
        apikey      => hiera('jenkins_api_key', 'XXX'),
        credentials => hiera('jenkins_credentials_id', 'XXX'),
      },
    ],
    rackspace_username       => hiera('nodepool_rackspace_username', 'username'),
    rackspace_password       => hiera('nodepool_rackspace_password', 'XXX'),
    rackspace_project        => hiera('nodepool_rackspace_project', 'project'),
    hpcloud_username         => hiera('nodepool_hpcloud_username', 'username'),
    hpcloud_password         => hiera('nodepool_hpcloud_password', 'XXX'),
    hpcloud_project          => hiera('nodepool_hpcloud_project', 'project'),
    ovh_username             => hiera('nodepool_ovh_username', 'username'),
    ovh_password             => hiera('nodepool_ovh_password', 'XXX'),
    ovh_project              => hiera('nodepool_ovh_project', 'project'),
    tripleo_username         => hiera('nodepool_tripleo_username', 'username'),
    tripleo_password         => hiera('nodepool_tripleo_password', 'XXX'),
    tripleo_project          => hiera('nodepool_tripleo_project', 'project'),
  }
}

# Node-OS: precise
# Node-OS: trusty
node 'zuul.openstack.org' {
  class { 'openstack_project::zuul_prod':
    project_config_repo            => 'https://git.openstack.org/openstack-infra/project-config',
    gerrit_server                  => 'review.openstack.org',
    gerrit_user                    => 'jenkins',
    gerrit_ssh_host_key            => hiera('gerrit_ssh_rsa_pubkey_contents', 'XXX'),
    zuul_ssh_private_key           => hiera('zuul_ssh_private_key_contents', 'XXX'),
    url_pattern                    => 'http://logs.openstack.org/{build.parameters[LOG_PATH]}',
    swift_authurl                  => 'https://identity.api.rackspacecloud.com/v2.0/',
    swift_user                     => 'infra-files-rw',
    swift_key                      => hiera('infra_files_rw_password', 'XXX'),
    swift_tenant_name              => hiera('infra_files_tenant_name', 'tenantname'),
    swift_region_name              => 'DFW',
    swift_default_container        => 'infra-files',
    swift_default_logserver_prefix => 'http://logs.openstack.org/',
    swift_default_expiry           => 14400,
    proxy_ssl_cert_file_contents   => hiera('zuul_ssl_cert_file_contents', 'XXX'),
    proxy_ssl_key_file_contents    => hiera('zuul_ssl_key_file_contents', 'XXX'),
    proxy_ssl_chain_file_contents  => hiera('zuul_ssl_chain_file_contents', 'XXX'),
    zuul_url                       => 'http://zuul.openstack.org/p',
    sysadmins                      => hiera('sysadmins', []),
    statsd_host                    => 'graphite.openstack.org',
    gearman_workers                => [
      'nodepool.openstack.org',
      'jenkins.openstack.org',
      'jenkins01.openstack.org',
      'jenkins02.openstack.org',
      'jenkins03.openstack.org',
      'jenkins04.openstack.org',
      'jenkins05.openstack.org',
      'jenkins06.openstack.org',
      'jenkins07.openstack.org',
      'jenkins-dev.openstack.org',
      'zm01.openstack.org',
      'zm02.openstack.org',
      'zm03.openstack.org',
      'zm04.openstack.org',
      'zm05.openstack.org',
      'zm06.openstack.org',
      'zm07.openstack.org',
      'zm08.openstack.org',
    ],
  }
}

# Node-OS: precise
# Node-OS: trusty
node /^zm\d+\.openstack\.org$/ {
  $group = "zuul-merger"
  class { 'openstack_project::zuul_merger':
    gearman_server       => 'zuul.openstack.org',
    gerrit_server        => 'review.openstack.org',
    gerrit_user          => 'jenkins',
    gerrit_ssh_host_key  => hiera('gerrit_ssh_rsa_pubkey_contents', 'XXX'),
    zuul_ssh_private_key => hiera('zuul_ssh_private_key_contents', 'XXX'),
    sysadmins            => hiera('sysadmins', []),
  }
}

# Node-OS: precise
# Node-OS: trusty
node 'zuul-dev.openstack.org' {
  class { 'openstack_project::zuul_dev':
    project_config_repo  => 'https://git.openstack.org/openstack-infra/project-config',
    gerrit_server        => 'review-dev.openstack.org',
    gerrit_user          => 'jenkins',
    gerrit_ssh_host_key  => hiera('gerrit_dev_ssh_rsa_pubkey_contents', 'XXX'),
    zuul_ssh_private_key => hiera('zuul_dev_ssh_private_key_contents', 'XXX'),
    url_pattern          => 'http://logs.openstack.org/{build.parameters[LOG_PATH]}',
    zuul_url             => 'http://zuul-dev.openstack.org/p',
    sysadmins            => hiera('sysadmins', []),
    statsd_host          => 'graphite.openstack.org',
    gearman_workers      => [
      'jenkins.openstack.org',
      'jenkins01.openstack.org',
      'jenkins02.openstack.org',
      'jenkins03.openstack.org',
      'jenkins04.openstack.org',
      'jenkins05.openstack.org',
      'jenkins06.openstack.org',
      'jenkins07.openstack.org',
      'jenkins-dev.openstack.org',
    ],
  }
}

# Node-OS: centos6
node 'pbx.openstack.org' {
  class { 'openstack_project::pbx':
    sysadmins     => hiera('sysadmins', []),
    sip_providers => [
      {
        provider => 'voipms',
        hostname => 'dallas.voip.ms',
        username => hiera('voipms_username', 'username'),
        password => hiera('voipms_password', 'XXX'),
        outgoing => false,
      },
    ],
  }
}

# Node-OS: precise
# A backup machine.  Don't run cron or puppet agent on it.
node /^ci-backup-.*\.openstack\.org$/ {
  $group = "ci-backup"
  include openstack_project::backup_server
}

# Node-OS: precise
# Node-OS: trusty
node 'proposal.slave.openstack.org' {
  include openstack_project
  class { 'openstack_project::proposal_slave':
    jenkins_ssh_public_key   => $openstack_project::jenkins_ssh_key,
    proposal_ssh_public_key  => hiera('proposal_ssh_public_key_contents', 'XXX'),
    proposal_ssh_private_key => hiera('proposal_ssh_private_key_contents', 'XXX'),
    zanata_server_url        => 'https://translate.openstack.org/',
    zanata_server_user       => hiera('proposal_zanata_user', 'XXX'),
    zanata_server_api_key    => hiera('proposal_zanata_api_key', 'XXX'),
  }
}

# Node-OS: trusty
node 'release.slave.openstack.org' {
  include openstack_project
  class { 'openstack_project::release_slave':
    pypi_username          => 'openstackci',
    pypi_password          => hiera('pypi_password', 'XXX'),
    jenkins_ssh_public_key => $openstack_project::jenkins_ssh_key,
    jenkinsci_username     => hiera('jenkins_ci_org_user', 'username'),
    jenkinsci_password     => hiera('jenkins_ci_org_password', 'XXX'),
    mavencentral_username  => hiera('mavencentral_org_user', 'username'),
    mavencentral_password  => hiera('mavencentral_org_password', 'XXX'),
    puppet_forge_username  => hiera('puppet_forge_username', 'username'),
    puppet_forge_password  => hiera('puppet_forge_password', 'XXX'),
    npm_username           => 'openstackci',
    npm_userpassword       => hiera('npm_user_password', 'XXX'),
    npm_userurl            => 'https://openstack.org',
  }
}

# Node-OS: precise
# Node-OS: trusty
node 'openstackid.org' {
  class { 'openstack_project::openstackid_prod':
    sysadmins               => hiera('sysadmins', []),
    site_admin_password     => hiera('openstackid_site_admin_password', 'XXX'),
    id_mysql_host           => hiera('openstackid_id_mysql_host', 'localhost'),
    id_mysql_password       => hiera('openstackid_id_mysql_password', 'XXX'),
    id_mysql_user           => hiera('openstackid_id_mysql_user', 'username'),
    id_db_name              => hiera('openstackid_id_db_name', 'XXX'),
    ss_mysql_host           => hiera('openstackid_ss_mysql_host', 'localhost'),
    ss_mysql_password       => hiera('openstackid_ss_mysql_password', 'XXX'),
    ss_mysql_user           => hiera('openstackid_ss_mysql_user', 'username'),
    ss_db_name              => hiera('openstackid_ss_db_name', 'username'),
    redis_password          => hiera('openstackid_redis_password', 'XXX'),
    ssl_cert_file_contents  => hiera('openstackid_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('openstackid_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('openstackid_ssl_chain_file_contents', 'XXX'),
  }
}

# Node-OS: precise
# Node-OS: trusty
node 'openstackid-dev.openstack.org' {
  class { 'openstack_project::openstackid_dev':
    sysadmins               => hiera('sysadmins', []),
    site_admin_password     => hiera('openstackid_dev_site_admin_password', 'XXX'),
    id_mysql_host           => hiera('openstackid_dev_id_mysql_host', 'localhost'),
    id_mysql_password       => hiera('openstackid_dev_id_mysql_password', 'XXX'),
    id_mysql_user           => hiera('openstackid_dev_id_mysql_user', 'username'),
    ss_mysql_host           => hiera('openstackid_dev_ss_mysql_host', 'localhost'),
    ss_mysql_password       => hiera('openstackid_dev_ss_mysql_password', 'XXX'),
    ss_mysql_user           => hiera('openstackid_dev_ss_mysql_user', 'username'),
    ss_db_name              => hiera('openstackid_dev_ss_db_name', 'username'),
    redis_password          => hiera('openstackid_dev_redis_password', 'XXX'),
    ssl_cert_file_contents  => hiera('openstackid_dev_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('openstackid_dev_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('openstackid_dev_ssl_chain_file_contents', 'XXX'),
  }
}

# Node-OS: centos6
# Node-OS: precise
# Node-OS: trusty
# This is not meant to be an actual node that connects to the master.
# This is a dummy node definition to trigger a test of the code path used by
# nodepool's prepare_node scripts in the apply tests
# NOTE(pabelanger): These are the settings we currently use for bare-* nodes.
# It includes thick_slave.pp.
node 'single-use-slave-bare' {
  class { 'openstack_project::single_use_slave':
    # Test non-default values from prepare_node_bare.sh
    sudo => true,
    thin => false,
  }
}

# Node-OS: centos6
# Node-OS: centos7
# Node-OS: fedora21
# Node-OS: precise
# Node-OS: trusty
# This is not meant to be an actual node that connects to the master.
# This is a dummy node definition to trigger a test of the code path used by
# nodepool's prepare_node scripts in the apply tests
# NOTE(pabelanger): These are the current settings we use for devstack-* nodes.
node 'single-use-slave-devstack' {
  class { 'openstack_project::single_use_slave':
    sudo => true,
    thin => true,
  }
}

# Node-OS: trusty
node 'kdc01.openstack.org' {
  class { 'openstack_project::kdc':
    sysadmins => hiera('sysadmins', []),
  }
}

# Node-OS: trusty
node 'kdc02.openstack.org' {
  class { 'openstack_project::kdc':
    sysadmins => hiera('sysadmins', []),
    slave     => true,
  }
}

# Node-OS: trusty
node /^afsdb.*\.openstack\.org$/ {
  $group = "afsdb"

  class { 'openstack_project::template':
    iptables_public_udp_ports => [7000,7002,7003,7004,7005,7006,7007],
    sysadmins                 => hiera('sysadmins', []),
    afs                       => true,
    manage_exim               => true,
  }

  include openstack_project::afsdb
}

# Node-OS: trusty
node /^afs.*\..*\.openstack\.org$/ {
  $group = "afs"

  class { 'openstack_project::template':
    iptables_public_udp_ports => [7000,7002,7003,7004,7005,7006,7007],
    sysadmins                 => hiera('sysadmins', []),
    afs                       => true,
    manage_exim               => true,
  }

  include openstack_project::afsfs
}

# Node-OS: trusty
node 'ask.openstack.org' {

  class { 'openstack_project::server':
    iptables_public_tcp_ports => [22, 80, 443],
    sysadmins                 => hiera('sysadmins', []),
  }

  class { 'openstack_project::ask':
    db_user                      => hiera('ask_db_user', 'ask'),
    db_password                  => hiera('ask_db_password', 'XXX'),
    redis_password               => hiera('ask_redis_password', 'XXX'),
    site_ssl_cert_file_contents  => hiera('ask_site_ssl_cert_file_contents', undef),
    site_ssl_key_file_contents   => hiera('ask_site_ssl_key_file_contents', undef),
    site_ssl_chain_file_contents => hiera('ask_site_ssl_chain_file_contents', undef),
  }
}

# Node-OS: trusty
node 'ask-staging.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [22, 80, 443],
    sysadmins                 => hiera('sysadmins', []),
  }

  class { 'openstack_project::ask_staging':
    db_password                  => hiera('ask_staging_db_password', 'XXX'),
    redis_password               => hiera('ask_staging_redis_password', 'XXX'),
  }
}

# Node-OS: trusty
node 'translate.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [80, 443],
    sysadmins                 => hiera('sysadmins', []),
  }
  class { 'openstack_project::translate':
    admin_users             => 'camunoz,cboylan,daisyycguo,infra,jaegerandi,lyz,mordred,stevenk',
    openid_url              => 'https://openstackid.org',
    listeners               => ['ajp'],
    from_address            => 'noreply@openstack.org',
    mysql_host              => hiera('translate_mysql_host', 'localhost'),
    mysql_password          => hiera('translate_mysql_password', 'XXX'),
    zanata_server_user      => hiera('proposal_zanata_user', 'XXX'),
    zanata_server_api_key   => hiera('proposal_zanata_api_key', 'XXX'),
    zanata_wildfly_version  => '9.0.1',
    zanata_url              => 'https://sourceforge.net/projects/zanata/files/webapp/zanata-war-3.7.1.war',
    zanata_checksum         => 'b741fac8cf7d11c9b15189e6899051eb',
    project_config_repo     => 'https://git.openstack.org/openstack-infra/project-config',
    ssl_cert_file_contents  => hiera('translate_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('translate_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('translate_ssl_chain_file_contents', 'XXX'),
  }
}

# Node-OS: trusty
node 'translate-dev.openstack.org' {
  class { 'openstack_project::translate_dev':
    sysadmins               => hiera('sysadmins', []),
    admin_users             => 'camunoz,cboylan,daisyycguo,infra,jaegerandi,lyz,mordred,stevenk',
    openid_url              => 'https://openstackid.org',
    listeners               => ['ajp'],
    from_address            => 'noreply@openstack.org',
    mysql_host              => hiera('translate_dev_mysql_host', 'localhost'),
    mysql_password          => hiera('translate_dev_mysql_password', 'XXX'),
    zanata_server_user      => hiera('proposal_zanata_user', 'XXX'),
    zanata_server_api_key   => hiera('proposal_zanata_api_key', 'XXX'),
    project_config_repo     => 'https://git.openstack.org/openstack-infra/project-config',
  }
}

# Node-OS: trusty
node 'apps.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [80, 443],
    sysadmins                 => hiera('sysadmins', []),
  }
  class { '::apps_site':
    ssl_cert_file           => '/etc/ssl/certs/apps.openstack.org.pem',
    ssl_cert_file_contents  => hiera('apps_ssl_cert_file_contents', 'XXX'),
    ssl_key_file            => '/etc/ssl/private/apps.openstack.org.key',
    ssl_key_file_contents   => hiera('apps_ssl_key_file_contents', 'XXX'),
    ssl_chain_file          => '/etc/ssl/certs/apps.openstack.org_intermediate.pem',
    ssl_chain_file_contents => hiera('apps_ssl_chain_file_contents', 'XXX'),
  }
}

# Node-OS: trusty
node 'odsreg.openstack.org' {
  class { 'openstack_project::server':
    iptables_public_tcp_ports => [80],
    sysadmins                 => hiera('sysadmins', []),
  }
  realize (
    User::Virtual::Localuser['ttx'],
  )
  class { '::odsreg':
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
