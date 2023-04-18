python
import socket
import sys
class PsqlAttachFile (gdb.Command):
  def __init__ (self):
    super (PsqlAttachFile, self).__init__ ("psql-attach-file", gdb.COMMAND_USER)

  def invoke (self, arg, from_tty):
    with open('/tmp/_pgsql_debug_pid', 'r') as fin: pid = fin.read();
    gdb.execute("attach {}".format(pid))

class PsqlAttach (gdb.Command):
  def __init__ (self):
    super (PsqlAttach, self).__init__ ("psql-attach", gdb.COMMAND_USER)

  def invoke (self, arg, from_tty):
    try:
      sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
      server_address = ('localhost', 5555)
      sock.connect(server_address)
      pid = sock.recv(16)
      print("recieved pid: {}",format(pid))
      pid = pid.decode('utf-8')
      print("recieved pid: {}".format(pid))
      cmd = "attach {}".format(pid)
      gdb.execute(cmd)
    finally:
      sock.close()

PsqlAttach()
PsqlAttachFile()
PsqlAttach()
PsqlAttachFile()
