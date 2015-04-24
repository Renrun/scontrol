include:
  - common


gitlab-base:
  pkg.installed:
    - pkgs:
        - openssh-server
        - postfix
        - cronie


gitlab-postfix:
  service.running:
    - name: postfix
    - enable: True
    - require:
      - pkg: gitlab-base
  cmd.wait:
    - name: chkconfig postfix on
    - user: root
    - group: root
    - watch:
      - service: gitlab-postfix


install_gitlab_rpm:
  file.managed:
    - name: /tmp/gitlab-ce-7.10.0~omnibus.2-1.x86_64.rpm
    - source: https://downloads-packages.s3.amazonaws.com/centos-6.6/gitlab-ce-7.10.0~omnibus.2-1.x86_64.rpm
    - source_hash: md5=529d69ec7e7c1ce456ad892fb7abe02b
    - makedirs: True
  cmd.wait:
    - name: rpm -ivh /tmp/gitlab-ce-7.10.0~omnibus.2-1.x86_64.rpm && gitlab-ctl reconfigure
    - user: root
    - group: root
    - watch:
      - file: install_gitlab_rpm
