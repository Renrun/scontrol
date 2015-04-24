include:
  - common

memcached:
  pkg.installed:
    - pkgs:
      - memcached
  file.managed:
    - name: /etc/sysconfig/memcached
    - source: salt://memcached/files/memcached.sysconfig
    - require:
      - pkg: memcached
  service.running:
    - enable: True
    - watch:
      - pkg: memcached
      - file: memcached
