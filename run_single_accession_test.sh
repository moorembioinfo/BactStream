#!/bin/bash
set -euo pipefail

ACCESSIONS="${1:-test/single_sra_accession.txt}"
REFERENCE="${REFERENCE:-refs/MG1655.fna}"
THREADS="${THREADS:-8}"
MEMORY="${MEMORY:-32}"

if [[ -z "${CONDA_PREFIX:-}" ]]; then
  echo "CONDA_PREFIX is not set. Activate the bactstream conda environment first:"
  echo "  conda activate bactstream"
  exit 1
fi

if [[ ! -f "$REFERENCE" ]]; then
  echo "Missing reference FASTA: $REFERENCE"
  exit 1
fi

if [[ ! -f "$ACCESSIONS" ]]; then
  echo "Missing accession file: $ACCESSIONS"
  exit 1
fi

if ! command -v snpEff.jar >/dev/null 2>&1; then
  bash install_snpeff_path.sh
fi

if [[ -z "${BACTSTREAM_BAKTA_DB:-}" ]]; then
  echo "BACTSTREAM_BAKTA_DB is not set."
  echo "Install and register the env-local Bakta DB first:"
  echo "  bash install_bakta_db.sh"
  echo "  conda deactivate"
  echo "  conda activate bactstream"
  exit 1
fi

echo "Running BactStream smoke test"
echo "  reference:  $REFERENCE"
echo "  accessions: $ACCESSIONS"
echo "  bakta db:   $BACTSTREAM_BAKTA_DB"
echo "  threads:    $THREADS"
echo "  memory:     ${MEMORY}G"

./BactStream \
  --reference "$REFERENCE" \
  --sra_ids "$ACCESSIONS" \
  --skip_assembly \
  --threads "$THREADS" \
  --memory "$MEMORY"
