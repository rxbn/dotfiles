# rxbn macOS dotfiles

## Configure Sudo to Use TouchID

```bash
sudo nvim /etc/pam.d/sudo
```

Add the following line to the top of the file:

```text
auth       sufficient     pam_tid.so
```

## Configure macOS

```bash
bash ./initial_setup.sh
```
