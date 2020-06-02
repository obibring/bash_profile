##
Dependencies:
- nvm
- pip

## Getting startedj
1. Clone the repo
```sh
> git clone https://github.com/obibring/bash_profile.git
```

2. Update values in `bash_profile.sh`
- Find occurrences of `/Users/orr` and replace with your
home directory.
- Update `$p` variable to point to the root of the plater repo.

Add Symlink
```sh
> ln -s <path to cloned directory>/bash_profile.sh ~/.bash_profile
> source ~/.bash_profile
```
