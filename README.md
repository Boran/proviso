# Proviso
[![Build
Status](https://travis-ci.org/proviso/proviso.png)](https://travis-ci.org/proviso/proviso)

NOTE on Sean's fork of tizzo's branch: 
- adding fixes ideas for the puppet side of things. A summary will be added here
/NOTE

Proviso aims to be an SDK+API to provision platform-independent local
VMs for Drupal development. The project seeks to develop an extensible
framework and ecosystem for developers to achieve parity with multiple
production deployment targets, as well as a one-click installer control
panel that makes advanced local development accessible.

For more information, please check the [Wiki](https://github.com/proviso/proviso/wiki).

To participate, see [contributing](https://github.com/proviso/proviso/blob/master/CONTRIBUTING.md).

Features
--------

  * Vagrant plugin management via [`bindler`][bindler].
  * Caches system packages (apt-get) between VM destroys via
    [`vagrant-cachier`][vagrant-cachier].


Pre-Requisites
--------------
- Git: http://git-scm.com/downloads
- Ruby: http://www.ruby-lang.org/en/downloads/
- RubyGems: http://rubygems.org/pages/download
- Rake: gem install rake
- Vagrant: http://downloads.vagrantup.com/

Usage
-----

### 1. Setup

    git clone https://github.com/proviso/proviso.git && cd proviso
    vagrant plugin install bindler
    vagrant bindler setup
    vagrant plugin bundle

### 2a. Chef

    vagrant up

### 2b. Puppet

    [sudo] gem install librarian-puppet
    cd puppet && librarian-puppet install
    PROVISO_PROVISIONER=puppet vagrant up

When using Puppet, you'll need to preface every vagrant command with
`PROVISO_PROVISIONER=puppet`. To avoid having to type this for each
command, you may also export this environment variable for the remainder
of your terminal session by running:

    export PROVISO_PROVISIONER=puppet



<!-- Links -->
   [bindler]:         https://github.com/fgrehm/bindler#readme
   [vagrant-cachier]: https://github.com/fgrehm/vagrant-cachier#readme
