#!/usr/bin/env bash

installer_options="--auto-dotfiles"

if
  [[ -d "/vagrant/rvm-src" ]]
then
  cd "/vagrant/rvm-src"
  sudo ./install "${installer_options}"
else
  echo "rvm-src not found falling back to download" >&2
  curl -L https://get.rvm.io | sudo bash -s -- "${installer_options}"
fi

for type in archives repos
do
  if
    [[ -d /vagrant/rvm-${type} ]]
  then
    rm -rf /usr/local/rvm/${type} &&
    ln -s /vagrant/rvm-${type}/ /usr/local/rvm/${type}
  else
    echo "rvm-${type} missing, shared ${type} disabled" >&2
  fi
done