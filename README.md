# Personal Ansible Desktop Configs

I use Ansible to configure all of my desktops, laptops, and servers. I use the Ansible Pull method to fully automate and script everything from system services to GNOME desktop settings.

## How does it work?
As mentioned above, it uses Ansible pull, so some familiarity with that is required. I use Ansible in "pull-mode" because it handles the dynamic nature of laptops and desktops better. Afterall, they aren't always turned on. And I don't like to maintain multiple things for one purpose, so I have the same repo configuring servers as well.

The folder structure breaks down like this:

**local.yml**: This is the Playbook that Ansible expects to find by default in pull-mode, think of it as an "index" of sorts that pulls other Playbooks in.


**ansible.cfg**: Configuration settings for Ansible goes here.


**group_vars/**: This directory is where I can place variables that will be applied on every system.


**host_vars/**: Each laptop/desktop/server gets a host_vars file in this folder, named after its hostname. Sets variables specific to that computer.


**hosts**: This is the inventory file. Even in pull-mode, an inventory file can be used. This is how Ansible knows what group to put a machine in.


**playbooks**: Additional playbooks that I may want to run, or have triggered.


**roles/**: This directory contains my base, workstation, and server roles. Every host gets the base role. Then either 'workstation' or 'server', depending on what it is.

**roles/base**: This role is for every host, regardles of the type of device it is. This role contains things that are intended to be on every host, such as default configs, users, etc.

**roles/workstation**: After the base role runs on a host, this role runs only on hosts that are designated to be workstations. GUI-specific things, such as GUI apps (Firefox, etc), Flatpaks, wallpaper, etc. Has a folder for the GNOME and MATE desktops.

**roles/server**: After the base role runs on a host, this role runs only on hosts designated as servers. Monitoring plugins, unattended-updates, server firewall rules, and other server-related things are configured here.

After it's run for the first time manually, this Ansible config creates its own Cronjob for itself on that machine so you never have to run it manually again going forward, and it will track all future commits and run them against all your machines as soon as you commit a change. You can find the playbook for Cron in the base role.

## How do I run it?
You run it with the following command after installing Ansible:

`ansible-pull --vault-password-file={path} -U https://github.com/kieran85james/ansible.git --ask-become-pass`

### Python Interpreter
Sometimes errors regarding python or python modules can occur. If you have a warning similar to: "A future installation of another Python interpreter could alter the one chosen" then try the following.

1. Run `ansible --version` and get the python version
2. Run `ansible-pull --vault-password-file={path} -U https://github.com/kieran85james/ansible.git --ask-become-pass --extra-vars ansible_python_interpreter=/usr/bin/python{{version}}`

You can read more on the topic [here](https://docs.ansible.com/ansible/latest/reference_appendices/interpreter_discovery.html).
