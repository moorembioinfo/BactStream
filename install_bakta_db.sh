#!/bin/bash
set -euo pipefail

if [[ -z "${CONDA_PREFIX:-}" ]]; then
  echo "CONDA_PREFIX is not set. Activate the bactstream conda environment first:"
  echo "  conda activate bactstream"
  exit 1
fi

DB_TYPE="${BAKTA_DB_TYPE:-light}"
DB_ROOT="${BAKTA_DB_ROOT:-$CONDA_PREFIX/share/bakta}"
ENV_FILE="$CONDA_PREFIX/etc/conda/activate.d/bactstream.sh"

if ! command -v bakta_db >/dev/null 2>&1; then
  echo "bakta_db is not in PATH. Install Bakta into the active environment first:"
  echo "  mamba install -c bioconda bakta=1.8.1 'pyrodigal<3'"
  exit 1
fi

mkdir -p "$DB_ROOT"

echo "Installing Bakta $DB_TYPE database under:"
echo "  $DB_ROOT"
bakta_db download --output "$DB_ROOT" --type "$DB_TYPE"

if [[ -d "$DB_ROOT/db-$DB_TYPE" ]]; then
  DB_PATH="$DB_ROOT/db-$DB_TYPE"
elif [[ -d "$DB_ROOT/db" ]]; then
  DB_PATH="$DB_ROOT/db"
else
  DB_PATH="$(find "$DB_ROOT" -maxdepth 2 -type f -name 'version.json' -printf '%h\n' | sort | head -n 1)"
fi

if [[ -z "${DB_PATH:-}" || ! -d "$DB_PATH" ]]; then
  echo "Bakta DB download finished, but no DB directory could be detected under $DB_ROOT"
  exit 1
fi

mkdir -p "$(dirname "$ENV_FILE")"
cat > "$ENV_FILE" <<EOF
export BACTSTREAM_BAKTA_DB="$DB_PATH"
EOF

export BACTSTREAM_BAKTA_DB="$DB_PATH"

echo
echo "Bakta DB ready:"
echo "  $BACTSTREAM_BAKTA_DB"
echo
echo "The path has been written to:"
echo "  $ENV_FILE"
echo
echo "Reactivate the environment to load it automatically in future shells:"
echo "  conda deactivate"
echo "  conda activate bactstream"
