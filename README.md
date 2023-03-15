Minimal reproduction of my difficulties in referencing Python dependencies to an AWS CloudWatch Synthetic

Even when a `pytest` directory is shown to exist, and the path to that directory is added to `sys.path`,
importing `pytest` still fails to find the module.

Create an AWS CLI profile named DevOps and run `./deploy.sh` to reproduce.


## Example log output:

```
sys.path outside methods is:
['/var/task', '/opt/python/lib/python3.8/site-packages', '/opt/python', '/var/runtime', '/var/lang/lib/python38.zip', '/var/lang/lib/python3.8', '/var/lang/lib/python3.8/lib-dynload', '/var/lang/lib/python3.8/site-packages', '/opt/python/lib/python3.8/site-packages', '/opt/python/', '/opt/python/lib/', '/tmp/python/lib/bin/', '/tmp/python/lib/', '/tmp/python/lib/fonts']
Trying to import outside methods
Failed to import pytest: No module named 'pytest'
[INFO]	2023-03-15T21:27:50.120Z	4caca22c-47c2-4d3d-8ad5-79897b2782f9	Calling customer canary: synthetic.handler()
The handler method has been called
sys.path inside methods is:
['/var/task', '/opt/python/lib/python3.8/site-packages', '/opt/python', '/var/runtime', '/var/lang/lib/python38.zip', '/var/lang/lib/python3.8', '/var/lang/lib/python3.8/lib-dynload', '/var/lang/lib/python3.8/site-packages', '/opt/python/lib/python3.8/site-packages', '/opt/python/', '/opt/python/lib/', '/tmp/python/lib/bin/', '/tmp/python/lib/', '/tmp/python/lib/fonts']
Trying to import inside method
Failed to import pytest: No module named 'pytest'
The contents of /opt/venv are
['bin', 'include', 'lib', 'pyvenv.cfg']
The contents of /opt/venv/lib/python3.8/site-packages/pytest are
['__init__.py', '__main__.py', '__pycache__', 'py.typed']
Extending sys.path with /opt/venv
sys.path is now
['/var/task', '/opt/python/lib/python3.8/site-packages', '/opt/python', '/var/runtime', '/var/lang/lib/python38.zip', '/var/lang/lib/python3.8', '/var/lang/lib/python3.8/lib-dynload', '/var/lang/lib/python3.8/site-packages', '/opt/python/lib/python3.8/site-packages', '/opt/python/', '/opt/python/lib/', '/tmp/python/lib/bin/', '/tmp/python/lib/', '/tmp/python/lib/fonts', '/opt/venv']
Trying to import after first sys.path extension
Failed to import pytest: No module named 'pytest'
Extending sys.path with /opt/venv/lib/python3.8/site-packages/pytest
sys.path is now
['/var/task', '/opt/python/lib/python3.8/site-packages', '/opt/python', '/var/runtime', '/var/lang/lib/python38.zip', '/var/lang/lib/python3.8', '/var/lang/lib/python3.8/lib-dynload', '/var/lang/lib/python3.8/site-packages', '/opt/python/lib/python3.8/site-packages', '/opt/python/', '/opt/python/lib/', '/tmp/python/lib/bin/', '/tmp/python/lib/', '/tmp/python/lib/fonts', '/opt/venv', '/opt/venv/lib/python3.8/site-packages/pytest']
Trying to import after second sys.path extension
Failed to import pytest: No module named 'pytest'
```
