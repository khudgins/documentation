#!/bin/bash

clouds=(atmos aws cloudsigma cloudstack ibm joyent nimbula openstack opsource rackspace vcloud zimory)
#clouds=(zimory)

CONFIGURATION='configuration.md'
CAPABILITIES='capabilities.md'

for c in ${clouds[*]}; do
  cd ${c}
  cp /Users/gmoselle/projects/dasein-cloud/wikis/dasein-cloud-${c}.wiki/Configuration.md ${CONFIGURATION}
  cp /Users/gmoselle/projects/dasein-cloud/wikis/dasein-cloud-${c}.wiki/Capabilities.md ${CAPABILITIES}

  pandoc -f markdown -t rst ${CONFIGURATION} -o ${CONFIGURATION%.*}.rst
  pandoc -f markdown -t rst ${CAPABILITIES} -o ${CAPABILITIES%.*}.rst

  rm -f ${CONFIGURATION}
  rm -f ${CAPABILITIES}

  awk 'NR==1{$0="\n"$0}1' ${CONFIGURATION%.*}.rst > blankline.rst
  awk 'NR==1{$0="-------------\n"$0}1' blankline.rst > dash.rst
  awk 'NR==1{$0="Configuration\n"$0}1' dash.rst > final.rst
  mv final.rst ${CONFIGURATION%.*}.rst

  awk 'NR==1{$0="\n"$0}1' ${CAPABILITIES%.*}.rst > blankline.rst
  awk 'NR==1{$0="------------\n"$0}1' blankline.rst > dash.rst
  awk 'NR==1{$0="Capabilities\n"$0}1' dash.rst > final.rst
  mv final.rst ${CAPABILITIES%.*}.rst

  rm -f {blankline,dash}.rst
  cd ..
done
