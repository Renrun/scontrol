include:
  - zabbix.config.saltmodule
  - zabbix.config.userparam


{% for app, app_config in pillar.get('zabbix_template', {}).items() %}

{{ app }}:
  zabbix.application:
    - name: {{ app }}

{% for item, item_config in app_config.get('items', {}).items() %}
{{ item }}:
  zabbix.item:
    - name: {{ item }}
    - key: {{ item_config.get('key', '') }}
    - application: {{ app }}
    - delta: {{ item_config.get('type', 0) }}
    - valuetype: {{ item_config.get('valuetype', 0) }}
{% for trigger, trigger_config in item_config.get('triggers', {}).items() %}
{{ trigger }}:
  zabbix.trigger:
    - name: {{ trigger }}
    - expression: {{ '\{' }}{{ app }}:{{ item_config.get('key', '') }}.{{ trigger_config.get('expression', '') }}{{ '\}' }}{{ trigger_config.get('condition', '') }}
    - priority: {{ trigger_config.get('priority', 3) }}
{% endfor %}
{% endfor %}

{% for graph, graph_config in app_config.get('graphs', {}).items() %}
{{ graph }}:
  zabbix.graph:
    - name: {{ graph }}
    - width: {{ graph_config.get('width', '') }}
    - height: {{ graph_config.get('heigh', '') }}
    - application: {{ app }}
    - keys:
    {% for key in graph_config.get('keys', []) %}
      - {{ app_config.get('items', {}).get(key).get("key") }}
    {% endfor %}
    - require:
    {% for key in graph_config.get('keys', []) %}
      - zabbix: {{ key }}
    {% endfor %}
{% endfor %}

{% endfor %}
