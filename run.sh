#!/usr/bin/env bash

if [ -z $COUNTRY ] || [ -z $ENVIRONMENT ]; then
    echo "Usage Sample: 'COUNTRY=hk ENVIRONMENT=prod ./run'"
    exit 1
fi

# Enable debugging, exit on undefined variable, exit on error, even if piped process exits non-0
set -xeuo pipefail

# Get script dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Where are tests? Relative path. Defaults to "Results"
TESTDIR="${TESTDIR:-Tests}"

# Output directory for results. Defaults to "Results"
OUTPUTDIR="${OUTPUTDIR:-Results}"

# Conn params to be updated if ENV CONNPARAMS is passed to script. See example usage
CONNPARAMS="${CONNPARAMS:- }"

# Tag to include. Defaults to none. Optional
TAG="${TAG:-none}"
TAGPARAM=$(
        if [[ "${TAG}" == "none" ]]; then
            echo -e "\n"
        else
            echo "-i ${TAG}"
        fi 
    )

# Change to script dir, so we can run 'Tests'
cd ${DIR}


pybot \
    ${CONNPARAMS}\
    --include ${COUNTRY} \
    ${TAGPARAM} \
    -d ${OUTPUTDIR} \
    -v "environment:${ENVIRONMENT}" \
    -v "country:${COUNTRY}" \
    ${TESTDIR}
