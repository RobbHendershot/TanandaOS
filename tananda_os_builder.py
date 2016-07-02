#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''tananda_os_builder

Usage:
    tananda_os_builder create <fedora_version>
    tananda_os_builder delete <fedora_version>
    tananda_os_builder list
    tananda_os_builder merge <fedora_version>
    tananda_os_builder build <fedora_version>    
    tananda_os_builder -h | --help
    tananda_os_builder -v | --version

Options:
    -h --help         Show this screen.
    -v --version    Show script version.

'''

from __future__ import unicode_literals, print_function
from docopt import docopt
from blessed import Terminal
from sh import git, curl, cd, mkdir, rm, meld, touch
from os import path

__version__ = "0.1.0"
__author__ = "Robb Hendershot"
__license__ = "MIT"

term = Terminal()
base_dir = path.dirname(path.realpath(__file__))
dist_name = "Tananda"
ks_files = [
    "live-base.ks",
    "live-workstation.ks",
    "repo-rawhide.ks",
    "repo.ks",
    "repo-not-rawhide.ks",
    "snippets/packagekit-cached-metadata.ks"
]


def main(docopt_args):

    if docopt_args["create"]:
        create(docopt_args["<fedora_version>"])

    elif docopt_args["delete"]:
        delete(docopt_args["<fedora_version>"])

    elif docopt_args["list"]:
        list()

    elif docopt_args["merge"]:
        merge(docopt_args["<fedora_version>"])

    elif docopt_args["build"]:
        build(docopt_args["<fedora_version>"])

    else:
        heading1("No usable commands found")


def create(version_number):
    heading1("Creating new version based on Fedora " + version_number + "\n")

    # Update git and create new version.
    heading2("Updating master branch.")
    print(git.checkout("master"))
    print(git.pull())  # Bring branch current.

    heading2("Creating new branch")
    print(git.checkout("-b" + version_number))  # Create working branch.

    # Get kickstart files.
    heading2("Creating fedora-kickstarts directory\n")
    mkdir("-p", (base_dir + "/fedora-kickstarts/"))
    cd(base_dir + "/fedora-kickstarts/")

    heading2("Downloading Fedora kickstart files.")
    ks_base = "https://pagure.io/fedora-kickstarts/raw/f" \
              + version_number + "/f"

    for file in ks_files:
        file_path = ks_base + "/fedora-" + file

        print ("Downloading " + file_path)
        curl("-O", file_path)


def merge(version_number):
    # Meld kickstart files together.
    heading1("Initiating kickstart file comparisons.")

    mkdir("-p", (base_dir + "/final-kickstarts/"))
    for file in ks_files:
        fedora_ks = base_dir + "/fedora-kickstarts/fedora-" + file
        tananda_ks = base_dir + "/tananda-kickstarts/tananda-" + file
        final_ks = base_dir + "/final-kickstarts/final-" + file

        print(touch(final_ks))

        meld("--auto-merge", fedora_ks, final_ks, tananda_ks)


def delete(version_number):
    heading1("Deleting version " + version_number + "\n")
    cd(base_dir)

    heading2("Removing branch from git.")
    print(git.checkout("master"))
    print(git.branch("-D", version_number))

    heading2("Deleting files.")
    print(rm("-rf", base_dir + "/fedora-kickstarts"))


def build(version_number):
    heading1("Writing version " + version_number + "ISO image.")

    heading2("Building ISO")
    sudo.livecd_creator(config=final_ks,
        fslabel=dist_name,
        releasever=version_number,
        title=dist_name,
        product=dist_name,
        cache=base_dir + "/cache/",
        tmpdir=base_dir + "/tmp/",
        verbose=true)

    heading2("Setting permissions on ISO")
    sudo.chown("rdhender:rdhender", base_dir + "/*.iso")
    sudo.chmod("775", "-R", base_dir + "/*.iso")

def list():
    heading1("Current versions")
    print (git.branch("--list"))

    print(path.dirname(path.realpath(__file__)))


def heading1(text):
    text.upper()

    print(term.bold + ("=" * 70))
    print(term.bold + text.upper() + term.normal + "\n")


def heading2(text):
    print(term.bold_underline + text + term.normal)


if __name__ == '__main__':
    args = docopt(__doc__, version=__version__)
    main(args)
