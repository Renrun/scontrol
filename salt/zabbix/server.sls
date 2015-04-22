include:
  - zabbix
  - zabbix.database


zabbix-server:
  pkg.installed:
    - pkgs:
      - zabbix20-server
      - mailx
  file.managed:
    - name: /etc/zabbix/zabbix_server.conf
    - source: salt://zabbix/files/zabbix_server.conf
    - template: jinja
    - defaults:
        dbname: {{ pillar['zabbix']['dbname'] }}
        dbuser: {{ pillar['zabbix']['dbuser'] }}
        dbpassword: "{{ pillar['zabbix']['dbpassword'] }}"
    - require:
      - pkg: zabbix-server
  service.running:
    - name: zabbix-server
    - enable: True
    - watch:
      - pkg: zabbix-server
      - file: zabbix-server
      - file: /etc/default/zabbix-server


/etc/default/zabbix-server:
  file.managed:
    - source: salt://zabbix/files/zabbix-server.default


zabbix-frontend:
  pkg.installed:
    - name: zabbix20-web-mysql
  file.managed:
    - name: /etc/zabbix/web/zabbix.conf.php
    - source: salt://zabbix/files/zabbix.conf.php
    - template: jinja
    - defaults:
        server: {{ pillar['zabbix']['server'] }}
        dbaddr: {{ pillar['zabbix']['dbaddr'] }}
        dbname: {{ pillar['zabbix']['dbname'] }}
        dbuser: {{ pillar['zabbix']['dbuser'] }}
        dbpassword: "{{ pillar['zabbix']['dbpassword'] }}"
    - require:
      - pkg: zabbix-frontend


zabbix-httpd:
  pkg.installed:
    - name: httpd
  file.managed:
    - name: /etc/httpd/conf.d/zabbix_phpconfig.conf
    - source: salt://zabbix/files/zabbix_phpconfig.conf.httpd
    - require:
      - pkg: zabbix-frontend
  service.running:
    - name: httpd
    - enable: True
    - watch:
      - pkg: zabbix-frontend
      - file: zabbix-frontend
      - file: zabbix-httpd
