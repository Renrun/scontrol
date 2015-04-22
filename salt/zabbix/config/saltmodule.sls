#include:
#  - zabbix.up


zapi:
  file.managed:
    - name: /usr/lib/python2.6/site-packages/salt/states/zapi.py
    - source: salt://zabbix/files/config/zapi.py


zabbix_module:
  file.managed:
    - name: /usr/lib/python2.6/site-packages/salt/states/zabbix.py
    - source: salt://zabbix/files/config/zabbix.py
    - template: jinja
    - defaults:
        web_api: {{ pillar['zabbix']['web_api'] }}
        web_user: {{ pillar['zabbix']['web_user'] }}
        web_pass: {{ pillar['zabbix']['web_pass'] }}
    - require:
      - file: zapi
