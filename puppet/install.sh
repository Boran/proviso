#!/usr/bin/env sh

echo ">>> install.sh: starting at `date +%H:%m` in `pwd`"

# Select a local mirror for better speed, or because you
# are behind alocal firewall
#mymirror=''
mymirror='mirror.switch.ch/ftp/mirror/ubuntu'   # Switzerland
if [ -n "$mymirror" ]; then
  echo ">>> install.sh: changing ubuntu mirror to $mymirror"
  sudo sed "s@us.archive.ubuntu.com/ubuntu@$mymirror@" -i /etc/apt/sources.list
  #behind a corporate firewall, may not have access to ubuntu security, rewrite that too:
  #sudo sed "s@scurity.ubuntu.com/ubuntu@$mymirror@" -i /etc/apt/sources.list  
  echo "    "
fi;

# Set myproxy for your environment or '' for none
myproxy=''
#myproxy='http://proxy.MYHOST.ch:80'
if [ -n "$myproxy" ]; then
  echo ">>> install.sh: set proxy to $myproxy, install php/pear"
  export http_proxy=$myproxy
  export https_proxy=$myproxy
  export ftp_proxy=$myproxy
  # Need php already to set pecl proxy
  #sudo apt-get -qq update
  sudo apt-get install -qqy php5-cli php-pear
  sudo pear config-set http_proxy $myproxy
  #sudo echo "Acquire::http::Proxy \"$myproxy\";" > /etc/apt/apt.conf.d/provisoproxy
  echo "    "
fi  

echo '>>> install.sh: Install latest puppet '
# Remove the versiono of puppet installed by the vagrant guys.
# Augeas is broken on it.
sudo rm -rf /opt/vagrant_ruby/lib/ruby/gems/1.8/gems/puppet*
sudo rm -rf /opt/vagrant_ruby/bin/puppet*
sudo rm -rf /opt/vagrant_ruby/bin/facter
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
rm -rf puppetlabs-release-precise.deb
sudo apt-get -qq update
# Install the most recent puppet (3.3.x)
sudo apt-get install --force-yes -qqy puppet

# Prevent errors by creating the default hiera.yaml because the installer won't.
sudo echo '---' > /etc/puppet/hiera.yaml
sudo echo ':backends: yaml' >> /etc/puppet/hiera.yaml
sudo echo ':yaml:' >> //etc/puppet/hiera.yaml
sudo echo '  :datadir: /var/lib/hiera' >> //etc/puppet/hiera.yaml
sudo echo ':hierarchy: common' >> //etc/puppet/hiera.yaml
sudo echo ':logger: console' >> //etc/puppet/hiera.yaml

echo ">>> install.sh: `date +%H:%m` pull down puppet modules in Puppetfile"
cd /vagrant/puppet
sudo apt-get install -qy rubygems
sudo gem install librarian-puppet
librarian-puppet install
echo ">>> install.sh done at `date +%H:%m`"

