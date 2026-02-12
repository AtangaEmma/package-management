## Spinning and connecting to virtual machins using virtual box

On your power shell (terminal)

- Craete a directory called ubuntu (mkdir ubuntu)
- Navigate to the directory (cd ubuntu)
- Initialize the directory with the required OS using vagrant
- Launch a virtual machine
- Connect to the virtual machine
- Go back on your browser and type 'vagrant boxes'
- At the top bar, Select 'vagrant cloud'
- Search and select 'Vagrant Box Catalog'
- Select 'Box seach page'
- Search for 'ubuntu/jammy' in the search bar 
- select the latest 'ubuntu/jammy64'
- Copy the initialization command of step 1
- Go back on your terminal and make sure you are in the ubuntu
  directory that you created, paste and run the command to initialize the ubuntu
- Run the command 'vagrant up' to create a virtual machine.
- Connect to the virtual machine by running the command "vagrant ssh"
