# __init__.py

from .ipc_connector import IPC

#  NOTE :
#   __init__.py will import any surface level modules(./)
#   _private contains modules used by the surface level modules
#       (__init__) - imports ./example.py | .example.class
#       (example.py) - this module will import from _private

# TODO :
# - Cleanup
# - README + Manual Pages(man)
