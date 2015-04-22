zabbix-base:
  pkg.installed:
    - pkgs:
        - MySQL-python
        - zabbix20-server-mysql


zabbix-database:
  mysql_database.present:
    - name: {{ pillar['zabbix']['dbname'] }}
    - connection_host: {{ pillar['zabbix']['dbaddr'] }}
    - connection_user: {{ pillar['zabbix']['dbrootuser'] }}
    - connection_pass: "{{ pillar['zabbix']['dbrootpassword'] }}"
    - require:
      - pkg: zabbix-base


zabbix-user:
  mysql_user.present:
    - host: localhost
    - name: {{ pillar['zabbix']['dbuser'] }}
    - password: "{{ pillar['zabbix']['dbpassword'] }}"
    - connection_host: {{ pillar['zabbix']['dbaddr'] }}
    - connection_user: {{ pillar['zabbix']['dbrootuser'] }}
    - connection_pass: "{{ pillar['zabbix']['dbrootpassword'] }}"
    - require:
      - pkg: zabbix-base


zabbix-grant:
  mysql_grants.present:
    - grant: all privileges
    - host: localhost
    - database: {{ pillar['zabbix']['dbname'] }}.*
    - user: {{ pillar['zabbix']['dbuser'] }}
    - connection_host: {{ pillar['zabbix']['dbaddr'] }}
    - connection_user: {{ pillar['zabbix']['dbrootuser'] }}
    - connection_pass: "{{ pillar['zabbix']['dbrootpassword'] }}"
    - require:
      - pkg: zabbix-base
      - mysql_database: zabbix-database
      - mysql_user: zabbix-user


zabbix-schema:
  cmd.wait:
    - name: mysql -u {{ pillar['zabbix']['dbrootuser'] }} -p"{{ pillar['zabbix']['dbrootpassword'] }}" {{ pillar['zabbix']['dbname'] }} < /usr/share/zabbix-mysql/schema.sql
    - watch:
      - mysql_database: zabbix-database


zabbix-images:
  cmd.wait:
    - name: mysql -u {{ pillar['zabbix']['dbrootuser'] }} -p"{{ pillar['zabbix']['dbrootpassword'] }}" {{ pillar['zabbix']['dbname'] }} < /usr/share/zabbix-mysql/images.sql
    - watch:
      - mysql_database: zabbix-database
    - require:
      - cmd: zabbix-schema


zabbix-data:
  cmd.wait:
    - name: mysql -u {{ pillar['zabbix']['dbrootuser'] }} -p"{{ pillar['zabbix']['dbrootpassword'] }}" {{ pillar['zabbix']['dbname'] }} < /usr/share/zabbix-mysql/data.sql
    - watch:
      - mysql_database: zabbix-database
    - require:
      - cmd: zabbix-schema
      - cmd: zabbix-images
