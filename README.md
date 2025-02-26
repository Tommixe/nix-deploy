## What you can do
The scope of this ansible playbook is to deploy a NixOS LXC containar on a proxmox node.
The playbook will:
1. download a container image from hydra.nixos.org
2. Generate a ssh keypair that you can use to access the new container
3. Install the required packeges in the proxmox host to run ansible
4. Create a new unprivileged lxc container (it will delete a previous created one with the same id, if present)
5. Upload the ssh public key generated at step 2
6. Bind mount an host folder inside the container
7. Update the container config file e proxmox host file to remap user and group IDs, to have the correct permission to access host file
8. Start the lxc container
9. You can now connect as root user to the container using the private ssh ket generate at step 1

## Configure
1. set variables in inventory.yml file
2. some values are stored as secrets in secretes.yaml file, but you can also set them directly in the inventory file. Just remember to do not commit them on a public repo
3. Update the roles/proxmox/tasks/configure_lxc.yml file to set the correct lxc.idmap based on your users. You can see [https://kloknibor.github.io/proxmox-lxc-id-mapper/](https://kloknibor.github.io/proxmox-lxc-id-mapper/)
4. If you are not using any bind mount you can remove the tasks: 'add mount mappings', 'edit /etc/subuid', 'edit /etc/subgid' and the option 'mounts' in the 'CREATE LXC' task

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
