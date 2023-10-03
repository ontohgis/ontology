#!/bin/sh

# uncomment (remove "#") the next line to download "rdf-toolkit.jar" to the "${HOME}" directory
#export JARP="${HOME}"

export JARURL=https://jenkins.edmcouncil.org/view/rdf-toolkit/job/rdf-toolkit-build/lastSuccessfulBuild/artifact/target/

# === don't touch anything below

test -n "${1}" || { echo "ERR: missing arg - full path to .ttl file" ; read -n 1 -s -r -p "Press any key to continue...." ; exit 1 ; }

curl --version &>/dev/null || { echo "ERR: missing curl" ; read -n 1 -s -r -p "Press any key to continue...." ; exit 1 ; }

java --version &>/dev/null || { echo "ERR: missing java - download e.g. from https://openjdk.org/install/ and install" ; read -n 1 -s -r -p "Press any key to continue...." ; exit 1 ; }

test -n "${JARP}" || export JARP="${TMPDIR:-/tmp}"
test -e "${JARP}"/rdf-toolkit.jar || { echo "INFO: downloading RDF Toolkit to \"${JARP}/rdf-toolkit.jar\"..." ; curl  --output-dir "${JARP}" -L -O "${JARURL}"/rdf-toolkit.jar 2>/dev/null ; echo "" ; }
test -e "${JARP}"/rdf-toolkit.jar || { echo "ERR: rdf-toolkit.jar cannot be downloaded" ; read -n 1 -s -r -p "Press any key to continue...." ; exit 1 ; }

export P="java -jar ${JARP}/rdf-toolkit.jar --source \"${1}\" --target \"${TMPDIR}/rdf-toolkit.ttl\" --use-dtd-subset --inline-blank-nodes --infer-base-iri"

echo "INFO: ${P}"
${P}

echo ""

diff -u "${1}" "${TMPDIR}/rdf-toolkit.ttl" &>/dev/null || { echo "WARN: move \"${TMPDIR}/rdf-toolkit.ttl\" \"${1}\"" ; mv -i -v "${TMPDIR}/rdf-toolkit.ttl" "${1}" ; }
rm -f "${TMPDIR}/rdf-toolkit.ttl"

read -n 1 -s -r -p "Press any key to continue...."
echo ""
