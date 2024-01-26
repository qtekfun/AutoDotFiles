#!/bin/bash

function get_os() {
    # Step 1: detect the current linux distro, version, and packaging system.
	#
	# We rely on a combination of 'uname' and /etc/os-release to find
	# an OS name and version, and from there work out what
	# installation method we should be using.
	#
	# The end result of this step is that the following three
	# variables are populated, if detection was successful.
	OS=""
	VERSION=""
	PACKAGETYPE=""
	APT_KEY_TYPE="" # Only for apt-based distros

	if [ -f /etc/os-release ]; then
		# /etc/os-release populates a number of shell variables. We care about the following:
		#  - ID: the short name of the OS (e.g. "debian", "freebsd")
		#  - VERSION_ID: the numeric release version for the OS, if any (e.g. "18.04")
		#  - VERSION_CODENAME: the codename of the OS release, if any (e.g. "buster")
		#  - UBUNTU_CODENAME: if it exists, use instead of VERSION_CODENAME
		. /etc/os-release
		case "$ID" in
			ubuntu|pop|neon|zorin)
				OS="ubuntu"
				if [ "${UBUNTU_CODENAME:-}" != "" ]; then
				    VERSION="$UBUNTU_CODENAME"
				else
				    VERSION="$VERSION_CODENAME"
				fi
				PACKAGETYPE="apt"
				# Third-party keyrings became the preferred method of
				# installation in Ubuntu 20.04.
				if expr "$VERSION_ID" : "2.*" >/dev/null; then
					APT_KEY_TYPE="keyring"
				else
					APT_KEY_TYPE="legacy"
				fi
				;;
			fedora)
				OS="$ID"
				VERSION=""
				PACKAGETYPE="dnf"
				;;
		esac
	fi

    echo "$OS"+

    return 0
}