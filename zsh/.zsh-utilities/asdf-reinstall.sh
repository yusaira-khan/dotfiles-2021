#!/bin/bash

for plugin in  $(asdf plugin-list) ; do
  echo $plugin
  for version in $(asdf list $plugin); do
     echo $version
     asdf uninstall $plugin $version
     asdf install $plugin $version
  done;
done

listpackages(){

   if [[ $plugin == ruby ]]
   then
     list="gem list --local"
   else
     list="echo oho"
   fi
   plugin_upcase=$(echo "$plugin" | tr '[:lower:]' '[:upper:]')
   ver_str="ASDF_${plugin_upcase}_VERSION=${version}"

   env $ver_str  $list
}
