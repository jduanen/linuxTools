#!/bin/bash
#
# Script to combine two or more PDF files into a single PDF output file

USAGE="combinePDFs.sh <pdfFile1,pdfFile2,...> <outputFile>"

if (( $# != 2 )); then
    echo "ERROR: wrong number of args"
    echo ${USAGE}
    exit 1
fi

inFilesList="${1}"
IFS=',' read -ra inFiles <<< "${inFilesList}"

if (( ${#inFiles[@]} < 2 )); then
    echo "ERROR: must give at least two input files"
    exit 1
fi

pdfunite ${inFiles[@]} ${2}
