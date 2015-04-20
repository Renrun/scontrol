base_packages:
  pkg.installed:
    - pkgs:
      - curl
      - git
      - htop
      - iotop
      - iftop
      - ntp
      - sudo
      - sysstat
      - tmux
      - tzdata
      - vim-enhanced
      - zip
      - zsh


/etc/sysctl.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://common/files/sysctl.conf


/etc/security/limits.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://common/files/limits.conf


/etc/sysconfig/i18n:
  file.append:
    - text:
      - LANG="en_US.UTF-8"
      - LC_CTYPE="en_US.UTF-8"
      - LC_ALL="en_US.UTF-8"
