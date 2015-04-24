include:
  - common

redis_packages:
  pkg.installed:
    - pkgs:
        - pexpect

get_redis:
  file.managed:
    - name: /srv/netinstall/{{ pillar['netinstall']['redis']['package'] }}
    - source: {{ pillar['netinstall']['redis']['source'] }}
    - source_hash: {{ pillar['netinstall']['redis']['source_hash'] }}
    - makedirs: True
  cmd.wait:
    - cwd: /srv/netinstall
    - name: {{ pillar['netinstall']['redis']['extract_cmd'] }}
    - watch:
      - file: get_redis

install_redis:
  file.managed:
    - name: /srv/netinstall/{{ pillar['netinstall']['redis']['extract_dir'] }}/utils/install_redis.py
    - source: salt://redis/files/install_redis.py
    - mode: 755
    - require:
      - cmd: get_redis
  cmd.wait:
    - name: {{ pillar['netinstall']['redis']['install_cmd'] }}
    - cwd: /srv/netinstall/{{ pillar['netinstall']['redis']['extract_dir'] }}
    - watch:
      - cmd: get_redis
    - require:
      - file: install_redis
      - cmd: get_redis
      - pkg: base_packages
      - pkg: redis_packages
