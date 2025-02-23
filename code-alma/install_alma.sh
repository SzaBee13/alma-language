#!/bin/bash

INSTALL_DIR="$HOME/.alma"
BIN_DIR="$HOME/.local/bin"

echo "Download and Install..."
mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"

git clone https://github.com/SzaBee13/alma-language.git "$INSTALL_DIR"

echo '#!/bin/bash' > "$BIN_DIR/alma"
echo "python3 $INSTALL_DIR/code-alma/alma_transpiler.py \"\$@\"" >> "$BIN_DIR/alma"
chmod +x "$BIN_DIR/alma"

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$HOME/.bashrc"
    echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$HOME/.zshrc"
    export PATH="$BIN_DIR:$PATH"
fi

echo "Alma installed! Run 'alma -v' to test."
