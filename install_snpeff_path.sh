#!/bin/bash
set -euo pipefail

if [[ -z "${CONDA_PREFIX:-}" ]]; then
  echo "CONDA_PREFIX is not set. Activate the bactstream conda environment first:"
  echo "  conda activate bactstream"
  exit 1
fi

JAR="$(find "$CONDA_PREFIX/share" -path '*/snpEff.jar' -type f | sort | head -n 1)"
if [[ -z "$JAR" ]]; then
  echo "Could not find snpEff.jar under $CONDA_PREFIX/share."
  echo "Install snpEff into the active environment with:"
  echo "  mamba install -c bioconda snpeff=5.1"
  echo "or:"
  echo "  conda install -c bioconda snpeff=5.1"
  exit 1
fi

mkdir -p "$CONDA_PREFIX/bin"
ln -sfn "$JAR" "$CONDA_PREFIX/bin/snpEff.jar"

echo "Linked snpEff.jar into PATH:"
echo "  $CONDA_PREFIX/bin/snpEff.jar -> $JAR"
echo
echo "Check:"
echo "  which snpEff.jar"
echo "  java -jar snpEff.jar -version"
