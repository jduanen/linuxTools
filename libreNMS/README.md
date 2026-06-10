# libreMNS

* Post-Install
  - Change port number in compose.yml file (e.g., to 8080)
  - Enable memory overcommit (without it, a background save or replication may fail under low memory conditions)
    * add 'vm.overcommit_memory = 1' to /etc/sysctl.conf
    * 'sysctl vm.overcommit_memory=1'
