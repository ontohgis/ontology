#!/bin/sh

# use an ontology file if no argument
export F=ontohgis.ttl

# uncomment (remove "#") the next line to download "rdf-toolkit.jar" to the "${HOME}" directory
#export JARP="${HOME}"

export JARURL=https://github.com/edmcouncil/rdf-toolkit/releases/latest/download/

# === don't touch anything below
export F="${1:-"$(dirname "${0}")/${F}"}"
test -s "${F}" || { test echo "ERR: missing ontology file" ; read -n 1 -s -r -p "Press any key to continue...." ; exit 1 ; }

curl --version &>/dev/null || { echo "ERR: missing curl" ; read -n 1 -s -r -p "Press any key to continue...." ; exit 1 ; }

java --version &>/dev/null || { echo "ERR: missing java - download e.g. from https://openjdk.org/install/ and install" ; read -n 1 -s -r -p "Press any key to continue...." ; exit 1 ; }

test -n "${JARP}" || export JARP="${TMPDIR:-/tmp}"
test -e "${JARP}"/rdf-toolkit.jar || { echo "INFO: downloading RDF Toolkit to \"${JARP}/rdf-toolkit.jar\"..." ; curl --output-dir "${JARP}" -L -R -O "${JARURL}"/rdf-toolkit.jar 2>/dev/null ; echo "" ; }
test -e "${JARP}"/rdf-toolkit.jar || { echo "ERR: rdf-toolkit.jar cannot be downloaded" ; read -n 1 -s -r -p "Press any key to continue...." ; exit 1 ; }

export P="java -jar ${JARP}/rdf-toolkit.jar --source \"${F}\" --target \"${TMPDIR}/rdf-toolkit.ttl\" --use-dtd-subset --inline-blank-nodes --infer-base-iri"

echo "INFO: ${P}"
${P}

echo ""

if ! diff -u "${F}" "${TMPDIR}/rdf-toolkit.ttl" &>/dev/null ; then
 echo "INFO: changing \"${F}\" ..."
 if ! mv -f -v "${TMPDIR}/rdf-toolkit.ttl" "${F}" &>/dev/null ; then
  echo "ERR: file \"${F}\" cannot be overwritten"
  echo "INFO: creating \"${F}.new\" ..."
  mv -f -v "${TMPDIR}/rdf-toolkit.ttl" "${F}.new"
 fi
fi
rm -f "${TMPDIR}/rdf-toolkit.ttl"

read -n 1 -s -r -p "Press any key to continue...."
echo ""
