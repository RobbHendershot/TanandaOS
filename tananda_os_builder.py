#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''tananda_os_builder

Usage:
  tananda_os_builder ship new <name>...
  tananda_os_builder ship <name> move <x> <y> [--speed=<kn>]
  tananda_os_builder ship shoot <x> <y>
  tananda_os_builder mine (set|remove) <x> <y> [--moored|--drifting]
  tananda_os_builder -h | --help
  tananda_os_builder --version

Options:
  -h --help     Show this screen.
  --version     Show version.
  --speed=<kn>  Speed in knots [default: 10].
  --moored      Moored (anchored) mine.
  --drifting    Drifting mine.
'''

from __future__ import unicode_literals, print_function
from docopt import docopt

__version__ = "0.1.0"
__author__ = "Robb Hendershot"
__license__ = "MIT"


def main():
    '''Main entry point for the tananda_os_builder CLI.'''
    args = docopt(__doc__, version=__version__)
    print(args)

if __name__ == '__main__':
    main()