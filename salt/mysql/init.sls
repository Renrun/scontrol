include:
  - common


install_mysql_repo:
  file.managed:
    - name: /tmp/mysql-community-release-el6-5.noarch.rpm
    - source: http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
    - source_hash: md5=1cbcf6b4ae7592b9ac100d9e7cd2ceb4
    - makedirs: True
  cmd.wait:
    - name: rpm -ivh /tmp/mysql-community-release-el6-5.noarch.rpm
    - user: root
    - group: root
    - watch:
      - file: install_mysql_repo


mysql:
  pkg.installed:
    - name: mysql-community-server
    - require:
      - cmd: install_mysql_repo
  file.managed:
    - name: /etc/my.cnf
    - source: salt://mysql/files/my.cnf
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require:
      - pkg: mysql
  service.running:
    - name: mysqld
    - enable: True
    - require:
      - pkg: mysql
      - file: mysql
    - watch:
      - file: mysql
  cmd.wait:
    - name: chkconfig mysqld on
    - user: root
    - group: root
    - watch:
      - service: mysql
