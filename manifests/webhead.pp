# bugzilla webhead: Configure a Bugzilla web server
class bugzilla::webhead (
  $bugzilla_admin_email,
  $bugzilla_admin_name,
  $bugzilla_admin_password,
  $bugzilla_db_user = "bugs",
  $bugzilla_db_passwd,
  $bugzilla_db_host = "127.0.0.1",
  $bugzilla_db_port = "3306",
  $bugzilla_db_database = "bugzilla3",
  $bugzilla_url = "bugzilla.$domain"
  ) {

    if $operatingsystem != "debian" {
      fail("bugzilla::webhead only supports Debian at this time.")
    }

    package { 'bugzilla3':
      ensure => installed,
    }

    file { '/usr/share/bugzilla3/web/data/answerfile':
      ensure  => file,
      require => Package['bugzilla3'],
      content  => template("bugzilla/webhead/answerfile.erb"),
    }

    file { '/etc/dbconfig-common/bugzilla3.conf':
      ensure  => file,
      require => Package['bugzilla3'],
      content  => template("bugzilla/webhead/bugzilla3.conf.erb"),
    }

    file { '/usr/share/bugzilla3/debian/localconfig':
      ensure  => file,
      require => Package['bugzilla3'],
      content  => template("bugzilla/webhead/localconfig.erb"),
    }
    # I think the website uses this one...
    file { '/etc/bugzilla3/localconfig':
      ensure  => file,
      require => Package['bugzilla3'],
      content  => template("bugzilla/webhead/localconfig.erb"),
    }


    file { '/etc/apache2/sites-available/bugzilla':
      ensure  => file,
      require => Package['apache2'],
      content  => template("bugzilla/webhead/vhost.erb"),
    }

    file { '/etc/apache2/sites-enabled/bugzilla':
      ensure  => link,
      target  => "/etc/apache2/sites-available/bugzilla",
      require => File['/etc/apache2/sites-available/bugzilla'],
    }

  }
            
