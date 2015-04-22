include:
  - zabbix.config.saltmodule
  - zabbix.config.template


{% for hostgroup in pillar.get('zabbix_host', {}).get('hostgroups', []) %}
{{ hostgroup }}:
  zabbix.hostgroup:
    - name: {{ hostgroup }}
{% endfor %}


{% for host, host_config in pillar.get('zabbix_host', {}).get('hosts', {}).items() %}
{{ host }}:
  zabbix.host:
    - name: {{ host }}
    - hostgroups:
    {% for hostgroup in host_config.get('hostgroups', []) %}
      - {{ hostgroup }}
    {% endfor %}
    - templates:
    {% for template in host_config.get('templates', []) %}
      - {{ template }}
    {% endfor %}
    - interface: {{ host_config.get('interface', '') }}
{% endfor %}
