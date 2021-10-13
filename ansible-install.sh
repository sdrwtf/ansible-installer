#!/bin/bash
#
# Simple script to install ansible on Ubuntu 20.04
# https://github.com/sdrwtf/ansible-installer
#

# Colors
RED='\033[0;31m'          # Red
GREEN='\033[0;32m'        # Green
YELLOW='\033[0;33m'       # Yellow
BLUE='\033[0;34m'         # Blue
NC='\033[0m'              # No Color

# Start
_main() {
  _is_root
  _os_version
}

# Check if script is run as root
_is_root() {
  if [[ "$EUID" -ne 0 ]]; then
    _die "Script needs to be run as root\n"
  fi
}

# Check OS and version
_os_version() {
  local os=""
  local ver_id=""

  if [[ -f /etc/os-release ]]; then
    . /etc/os-release

    local os=$NAME
    local ver_id=$VERSION_ID
  fi

  if [[ ${os} != "Ubuntu" ]] || [[ ${ver_id} != "20.04" ]]; then

    if [[ ${os} = "" ]] || [[ ${ver_id} = "" ]]; then
      _warn "Could not detect OS. Please note\n" \
            "        that this script is only tested for Ubuntu 20.04!\n"
    else
      _warn "Seems like you are running ${os} ${ver_id}. Please note\n" \
            "        that this script is only tested for Ubuntu 20.04!\n"
    fi


    if _ask "Continue anyways?"; then
      _install
    else
      _die "Aborted by user\n"
    fi

  else
    _install
  fi
}

# Main installation
_install() {

  _warn "Begin of installation. This consists of:\n" \
        "        - update repositories\n" \
        "        - install paket software-properties-common\n" \
        "        - add PPA ansible/ansible\n" \
        "        - install ansible\n"

  if _ask "Continue?"; then

    _info "Updating repositories\n"
    apt update || \
    _die "Could not update repositories\n"

    _info "Installing paket software-properties-common\n"
    apt install software-properties-common --yes || \
    _die "Installation of paket software-properties-common failed\n"

    _info "Adding PPA ansible/ansible\n"
    add-apt-repository --yes --update ppa:ansible/ansible || \
    _die "Could not add PPA ansible/ansible\n"

    _info "Installing paket ansible and its dependencies\n"
    apt install ansible --yes || \
    _die "Could not install paket ansible\n"

    _good "Done\n\n$(ansible --version)\n"
  else
    _die "Aborted by user\n"
  fi
}

# Check OS and version
_os_version() {
  local os=""
  local ver_id=""

  if [[ -f /etc/os-release ]]; then
    . /etc/os-release

    local os=$NAME
    local ver_id=$VERSION_ID
  fi

  if [[ ${os} != "Ubuntu" ]] || [[ ${ver_id} != "20.04" ]]; then

    if [[ ${os} = "" ]] || [[ ${ver_id} = "" ]]; then
      _warn "Could not detect OS. Please note\n" \
            "        that this script is only tested for Ubuntu 20.04!\n"
    else
      _warn "Seems like you are running ${os} ${ver_id}. Please note\n" \
            "        that this script is only tested for Ubuntu 20.04!\n"
    fi


    if _ask "Continue anyways?"; then
      _install
    else
      _die "Aborted by user\n"
    fi

  else
    _install
  fi
}

# Great general-purpose function to ask Yes/No questions by Dave James Miller
# https://gist.github.com/davejamesmiller/1965569
_ask() {
  local prompt default reply

  if [[ ${2:-} = 'Y' ]]; then
    prompt='Y/n'
    default='Y'
  elif [[ ${2:-} = 'N' ]]; then
    prompt='y/N'
    default='N'
  else
    prompt='y/n'
    default=''
  fi

  while true; do

    # Ask the question (not using "read -p" as it uses stderr not stdout)
    echo -n "$1 [$prompt] "

    # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
    read -r reply </dev/tty

    # Default?
    if [[ -z $reply ]]; then
      reply=$default
    fi

    # Check if the reply is valid
    case "$reply" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

_good() {
  echo -e >&2 "\n${GREEN}:: INFO: $*${NC}"
}

_info() {
  echo -e >&2 "\n${BLUE}:: INFO: $*${NC}"
}

_warn() {
  echo -e >&2 "\n${YELLOW}:: WARN: $*${NC}"
}

_error() {
  echo -e >&2 "\n${RED}:: ERROR: $*${NC}"
}

_die() {
  echo -e >&2 "\n${RED}:: ABORT: $*${NC}"
  exit 1
}

_main