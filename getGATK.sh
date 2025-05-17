#!/bin/bash

# === Setup variables ===
GATK_VERSION="4.5.0.0"
INSTALL_DIR="$HOME/tools/gatk"
ZIP_NAME="gatk-${GATK_VERSION}.zip"
URL="https://github.com/broadinstitute/gatk/releases/download/${GATK_VERSION}/${ZIP_NAME}"

# === Create install directory ===
mkdir -p "$HOME/tools"

# === Download GATK ===
echo "Downloading GATK $GATK_VERSION..."
wget -O "$ZIP_NAME" "$URL" || { echo "Download failed"; exit 1; }

# === Unzip ===
unzip -q "$ZIP_NAME" -d "$HOME/tools" || { echo "Unzip failed"; exit 1; }

# === Rename to standard path ===
mv "$HOME/tools/gatk-${GATK_VERSION}" "$INSTALL_DIR"

# === Clean up ===
rm "$ZIP_NAME"

# === Add to PATH (if not already there) ===
if ! grep -q 'tools/gatk' "$HOME/.bashrc"; then
  echo 'export PATH="$HOME/tools/gatk:$PATH"' >> "$HOME/.bashrc"
  echo "Added GATK to PATH in .bashrc"
else
  echo "GATK path already present in .bashrc"
fi

# === Apply new PATH immediately ===
export PATH="$INSTALL_DIR:$PATH"

# === Test ===
echo "Testing GATK..."
gatk --help | head -n 5

echo "✅ GATK setup complete. Restart your shell or run: source ~/.bashrc"
