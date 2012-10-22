mirage-vagrant
==============

A (hopefully) easy way to get started with Mirage by using Vagrant.

Getting started
---------------
1. Fork this repo
2. Install VirtualBox
3. Install Vagrant
4. Run vagrant box add precise64 http://files.vagrantup.com/precise64.box
5. Generate and download an X509 certificate from AWS. Put them in the puppet folder.
6. Edit puppet/default.pp and change AMAZON_CERT_NAME to match the common part of the filename for the key/certificate you downloaded
7. Fill in all your EC2 access information in puppet/setup.sh
8. Run vagrant up
9. Run vagrant ssh
10. In your vm, cd /vagrant
11. Run puppet/setup.sh. Wait. Drink some coffee.
12. Run make && make run
13. Visit localhost:8080 on the host machine--you should see "test" as the response

Deploy to Amazon
----------------
1. Run vagrant ssh
2. cd /vagrant
3. make deploy
4. ec2-run-instances [AMI THAT WAS OUTPUT WITH LAST COMMAND]

Thanks
======
Thanks to @avsm for his work on helping me get started with mirage and anyone else who has worked on mirage or mirage-www.