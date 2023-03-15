import importlib
import os
import sys

MODULE_NAME = 'pytest'
DEPENDENCIES_PATH = '/opt/venv'
PYTEST_PATH = '/opt/venv/lib/python3.8/site-packages/pytest'


def handler(event, context):
    print('The handler method has been called')
    print('sys.path inside methods is:')
    print(sys.path)
    print('Trying to import inside method')
    try_to_import(MODULE_NAME)

    print(f'The contents of {DEPENDENCIES_PATH} are')
    print(os.listdir(DEPENDENCIES_PATH))
    print(f'The contents of {PYTEST_PATH} are')
    print(os.listdir(PYTEST_PATH))

    print(f'Extending sys.path with {DEPENDENCIES_PATH}')
    sys.path.append(DEPENDENCIES_PATH)
    print('sys.path is now')
    print(sys.path)
    print('Trying to import after first sys.path extension')
    try_to_import(MODULE_NAME)

    print(f'Extending sys.path with {PYTEST_PATH}')
    sys.path.append(PYTEST_PATH)
    print('sys.path is now')
    print(sys.path)
    print('Trying to import after second sys.path extension')
    try_to_import(MODULE_NAME)


def try_to_import(name_of_module):
    try:
        importlib.import_module(name_of_module)
        print(f'Successfully imported {name_of_module}')
    except Exception as e:
        print(f'Failed to import {name_of_module}: {e}')


# Normally imports would go at the top of a file, but not in this case
# where I'm calling a method in order to import
print('sys.path outside methods is:')
print(sys.path)
print('Trying to import outside methods')
try_to_import(MODULE_NAME)
