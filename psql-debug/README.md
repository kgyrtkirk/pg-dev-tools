## psql wrapper for debugging

This makes it a bit easier to attach to pg behind a psql session.

The wrapper follows a few simple principles:
* always writes the last pid to `/tmp/_pgsql_debug_pid`
  * so its easy to attach to the last running one
* service the pid thru a TCP socket - and wait for the debugger
  * `PSQL_DEBUG=wait psql ...`
* the script hacks in itself even in case there are `-X` arguments passed to `psql`
* detects `pg_regress` execution and auto-skips init commands
  * if mode is set to `wait` it will stop and wait for the debugger
* there's a sample `launch.json` to be used with `vscode`; it requires the `augustocdias.tasks-shell-input` to operate
* some `gdbinit` commands are also available (`psql-attach`/`psql-attach-file`)
  * I don't use them as `vscode` knows only `attach` or `launch` modes...
