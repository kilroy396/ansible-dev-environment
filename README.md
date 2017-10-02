1. Create a ssh keypair named ansible

    ```
    ssh-keygen -t rsa -f ansible
    ```
  
2. Copy the keypair to the env/ subdirectory

3. Add the following to the localhosts ~/.ssh/config

    ```
    Host control ansible-control-node
      HostName 10.1.3.8
      User ansible
      IdentityFile ~/.ssh/ansible
      StrictHostKeyChecking no
      UserKnownHostsFile=/dev/null
    ```
  
4. Move the ansible keypair to the ~/.ssh folder

5. Adjust the Vagrant file for the number of required servers, if more than 10 you will need to edit files.

6. In the development-project directory put your ansible code base.  e.g. `git clone git@github.com:kilroy396/ansible-stub.git`

7. `vagrant up --provider virtualbox`

8. `ssh ansible-control-node`

9. Execute the script ~/initial_setup.sh to deploy ansible.

10. Change to the /development directory and start using ansible.
