# ansible-installer

## About

I wanted to have a simple bash script to install Ansible on Ubuntu 20.04, so here it is. The only thing it does is following the official [install instructions provided by Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu).

> :warning: This script is only tested on Ubuntu 20.04! It might work on other debian based distros, try at own risk.

## Features

- Updates software repositories
- Installs `software-properties-common`
- Adds `ppa:ansible/ansible`
- Installs Ansible with dependecies
- Copies `.ansible.cfg` from this repo into `/root/` to enable colorful output if Ansible is run as `sudo ansible-pull -U ...`

## Usage

1. Clone or download this repository to your local machine
2. Make the script executeable
   ```bash
   chmod +x ansible-install.sh
   ```
3. Run script as root
   ```bash
   sudo ./ansible-install.sh
   ```

## Contributing

Any contributions you make are greatly appreciated. If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue if you like.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

## Acknowledgments

- [Dave James Miller's Bash General-Purpose Yes/No Prompt Function ("ask")](https://gist.github.com/davejamesmiller/1965569)
