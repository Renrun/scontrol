include:
  - zabbix

zabbix-agent:
  pkg.installed:
    - name: zabbix20-agent
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.conf
    - source: salt://zabbix/files/zabbix_agentd.conf
    - template: jinja
    - defaults:
        server: {{ pillar['zabbix']['server'] }}
        hostname: {{ grains['host'] }}
    - require:
      - pkg: zabbix-agent
  service.running:
    - enable: True
    - watch:
      - pkg: zabbix-agent
      - file: /etc/zabbix/zabbix_agentd.conf
