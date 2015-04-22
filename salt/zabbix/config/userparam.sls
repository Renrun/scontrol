include:
  - zabbix.agent


/etc/zabbix/zabbix_agentd.conf.d:
  file.directory:
    - user: zabbix
    - group: zabbix
    - dir_mode: 755


plugin-mysql:
  file.managed:
    - name: /etc/zabbix/plugin/check_mysql.sh
    - source: salt://zabbix/files/config/check_mysql.sh
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - dir_mode: 755


up-mysql:
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.conf.d/userparameter_mysql.conf
    - source: salt://zabbix/files/config/userparameter_mysql.conf
    - template: jinja
    - defaults:
        dbmonitoruser: {{ pillar['zabbix']['dbmonitoruser'] }}
        dbmonitorpassword: {{ pillar['zabbix']['dbmonitorpassword'] }}
    - require:
      - pkg: zabbix-agent
      - file: /etc/zabbix/zabbix_agentd.conf.d
    - watch_in:
      - service: zabbix-agent


up-socket:
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.conf.d/userparameter_socket.conf
    - source: salt://zabbix/files/config/userparameter_socket.conf
    - require:
      - pkg: zabbix-agent
      - file: /etc/zabbix/zabbix_agentd.conf.d
    - watch_in:
      - service: zabbix-agent
