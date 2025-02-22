## Credits

## Configure
1. set variables in inventory.yml file
2. some values are stored as secrets in secretes.yaml file, but you can also set them directly in the inventory file. Just remember to do not commit them on a public repo

## Deploy using make commands

1. nix-shell (if you have nix installed)
2. make ansible
3. provide ssh password to connect to your proxmox node using the user specified in pm_user variable
4. when prompted provide again proxmox root password to create LXC container 


## if you want to use SOPS to encrypt secrets
1. you need to have sops installed. if you want you can run nix-shell to have a temporary shell with sops installed
2. Copy your public age key in the .sops.yaml file replacing the one called user01
3. delete secrets.yaml file to create a new one
3. run: sops secrets.yaml to create a new file and set the hidden variable as in the secrets.yaml.sample file

## To create a age key
1. You can use an existing ssh private key or create e new one:

    ``` ssh-keygen -t ed25519 -f ~/.ssh/ssh_sops_key -C "sops key" ```
    
2. Generate an age private key using the just created ssh key, the key is generated in default folder used by sops:

    ``` ssh-to-age -private-key -i ~/.ssh/ssh_sops_key > ~/.config/sops/age/keys.txt ```

3. Get the age public key:

    ``` age-keygen -y ~/.config/sops/age/keys.txt ```

4. Copy the age public key in the .sops.yaml file