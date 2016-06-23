#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''tananda_os_builder

Usage:
  tananda_os_builder create <fedora_version>
  tananda_os_builder -h | --help
  tananda_os_builder -v | --version

Options:
  -h --help     Show this screen.
  -v --version  Show version.

'''

from __future__ import unicode_literals, print_function
from docopt import docopt
from blessed import Terminal
from sh import ls, git


__version__ = "0.1.0"
__author__ = "Robb Hendershot"
__license__ = "MIT"


def main(docopt_args):

	if docopt_args["create"]:
		create(docopt_args["<fedora_version>"])


def create(version_number):
	heading1("Creating new version based on Fedora " + version_number + "\n") # Switch to master branch.

	# Update git and create new version.
	heading2("Updating master branch.")
	print(git.checkout("master"))
	print(git.pull()) # Bring branch current. 

	heading2("Creating new branch")
	print(git.checkout("-b" + version_number)) # Create working branch.

	# Get kickstart files.
	# Meld kickstart files together.


def delete(version_number):
	heading1("Deleting version " + version_number + "\n")
	print(git.checkout("master"))
	print(git.branch("-D", version_number))


def heading1(text):

	term = Terminal()

	text.upper()

	print(term.bold + ("=" * 70))
	print(term.bold + text.upper() + term.normal)


def heading2(text):

	term = Terminal()

	print(term.bold_underline + text + term.normal)


if __name__ == '__main__':
  args = docopt(__doc__, version=__version__)
  main(args)
