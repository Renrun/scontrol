#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os

from fabric.api import (
    env,
    hosts,
    execute,
    run,
    settings,
    sudo,
    task,
)

from fabric.contrib.project import rsync_project

from fabtools.vagrant import vagrant

# fix env settings
env.use_ssh_config = True
env.keepalive = 60

MASTER_CONF = """
file_roots:
  base:
    - /srv/scontrol/salt
  dev:
    - /srv/scontrol/salt/dev
  prod:
    - /srv/scontrol/salt/prod

pillar_roots:
  base:
    - /srv/scontrol/pillar
  dev:
    - /srv/scontrol/pillar/dev
  prod:
    - /srv/scontrol/pillar/prod

log_level: debug
log_level_logfile: debug
"""


@task
def deploy():
    # fix permission
    sudo("mkdir -p /srv/scontrol")
    sudo("chown {0} -R /srv/scontrol".format(env.user))

    # rsync deploy
    params = {
        'remote_dir': "/srv/",
        'local_dir': os.path.dirname(os.path.realpath(__file__)),
        'delete': True,
        'extra_opts': ("--force --progress --delay-updates "
                       "--exclude-from=rsync_exclude.txt"),
    }
    with settings(warn_only=True):
        rsync_project(**params)

    sudo("chown root:root -R /srv/scontrol")
    sudo("service salt-master restart")
    sudo("salt '*' saltutil.refresh_pillar")


@task
def apply(minions='*'):
    sudo("salt '{}' state.highstate".format(minions))


@task
def sign_cert(certname):
    sudo("sudo salt-key -a {}".format(certname))


@task
def deploy_master():
    # install puppet if needed
    if not command_exist('salt-master'):
        sudo("curl -L https://raw.githubusercontent.com/saltstack/salt-bootstrap/stable/bootstrap-salt.sh | sh -s -- -M -N")

    sudo("echo -e '{}' > /etc/salt/master".format(MASTER_CONF))
    execute(deploy)


@task
def deploy_minion(master=None):
    master = master or "127.0.0.1"

    # install salt-minion if needed
    if not command_exist('salt-minion'):
        sudo("curl -L https://raw.githubusercontent.com/saltstack/salt-bootstrap/stable/bootstrap-salt.sh | sh -s --")

    sudo("sed -i 's/#master: salt/master: {}/' /etc/salt/minion".format(
        master))
    sudo("service salt-minion restart")


def command_exist(command):
    """
    Tests if the given command is available on the system.
    """
    result = run("which '%s' >& /dev/null && echo OK ; true" % command)
    return result.endswith("OK")
