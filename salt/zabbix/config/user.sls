include:
  - zabbix.config.saltmodule
  - zabbix.config.template


{% for usergroup, usergroup_config in pillar.get('zabbix_user', {}).get('usergroups', {}).items() %}
{{ usergroup }}:
  zabbix.usergroup:
    - name: {{ usergroup }}
    - status: {{ usergroup_config.get('status', 0) }}
{% endfor %}


{% for user, user_config in pillar.get('zabbix_user', {}).get('users', {}).items() %}
{{ user }}:
  zabbix.user:
    - name: {{ user }}
    - lastname: {{ user_config.get('lastname', '') }}
    - firstname: {{ user_config.get('firstname', '') }}
    - passwd: {{ user_config.get('passwd', '') }}
    - usergroups:
    {% for usergroup in user_config.get('usergroups', []) %}
      - {{ usergroup }}
    {% endfor %}
    - sendto: {{ user_config.get('sendto', '') }}
{% endfor %}


{% for trigger, trigger_config in pillar.get('zabbix_user', {}).get('triggers', {}).items() %}
{{ trigger }}:
  zabbix.trigger:
    - name: {{ trigger }}
    - expression: {{ trigger_config.get('expression', '') }}
    - priority: {{ trigger_config.get('priority', 3) }}
{% endfor %}


{% for action, action_config in pillar.get('zabbix_user', {}).get('actions', {}).items() %}
{{ action }}:
  zabbix.action:
    - name: {{ action }}
    - trigger_filter: {{ action_config.get('trigger_filter', '') }}
    - notify_usergroup: {{ action_config.get('notify_usergroup', '') }}
{% endfor %}
