ansible-bash_it
===============

Ansible role to deploy [bash-it](https://github.com/Bash-it/bash-it) framework -
a collection of community Bash commands ands scripts.

[![Build Status](https://travis-ci.org/mmannerm/ansible-bash_it.svg?branch=master)](https://travis-ci.org/mmannerm/ansible-bash_it)

Usage
-----

Include the role, and specify the user you want to install the bash-it for.
Note: The role will change the default shell for the user to be `/bin/bash`.

| Variable       | Default value                          | Description                                |
|----------------|----------------------------------------|--------------------------------------------|
| user           | {{ ansible_user_id }}                  | User to install bash-it for                |
| theme          | pure                                   | Bash-it Theme to install                   |
| aliases        | []                                     | A list of aliases to install               |
| plugins        | []                                     | A list of plugins to install               |
| completions    | []                                     | A list of completions to install           |
| repository     | https://github.com/bash-it/bash-it.git | Git repository for the bash-it             |
| version        | master                                 | Git version tag to retrieve                |
| bashrc_install | true                                   | Update .bashrc to source bash_it.sh or not |

If you have wish to update `~/.bashrc` yourself rather than have this role
add code to source `bash_it.sh`, set the `bashrc_install` variable to `false`.

Example Playbook
----------------

```yaml
- hosts: servers
  roles:
    - role: mmannerm.bash_it
      user: vagrant
      aliases:
        - general
        - ansible
      plugins:
        - history
      completions:
        - git
```

License
-------

Apache 2.0

Author Information
------------------

Mika Mannermaa
