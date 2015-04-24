#!/usr/bin/env python

import pexpect
import sys

port_command = "%s\r" % sys.argv[1]

child = pexpect.spawn("env -i PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH ./install_server.sh")
child.expect('redis port')
child.sendline(port_command)
child.expect('redis config')
child.sendline('\r')
child.expect('redis log')
child.sendline('\r')
child.expect('data directory')
child.sendline('\r')
child.expect('redis executable')
child.sendline('\r')
child.expect('ENTER')
child.sendline('\r')
child.eof()
child.close()
