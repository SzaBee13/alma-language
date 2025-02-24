#!/bin/bash

INSTALL_DIR="$HOME/.alma"
BIN_DIR="$HOME/.local/bin"
TRANSPILER="$INSTALL_DIR/code-alma/alma_transpiler.py"
SHELL_CONFIG="$HOME/.zshrc"  # macOS default shell is zsh

echo "📥 Installing Alma Language for macOS..."

# Create necessary directories
mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"

# Download files (if not cloned, manually copy them)
if [ "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
fi
git clone https://github.com/SzaBee13/alma-language.git "$INSTALL_DIR"

# Find Node.js path (in case it's not in /usr/local/bin)
NODE_PATH=$(which node)
if [ -z "$NODE_PATH" ]; then
    echo "❌ Node.js not found! Please install it first."
    exit 1
fi

# Create executable Alma script
echo '#!/bin/bash' > "$BIN_DIR/alma"
echo "TRANSPILER=\"$TRANSPILER\"" >> "$BIN_DIR/alma"
echo "NODE=\"$NODE_PATH\"" >> "$BIN_DIR/alma"
echo 'if [[ "$1" == "-v" || "$1" == "--version" ]]; then' >> "$BIN_DIR/alma"
echo '    python3 "$TRANSPILER" -v' >> "$BIN_DIR/alma"
echo '    exit 0' >> "$BIN_DIR/alma"
echo 'fi' >> "$BIN_DIR/alma"
echo 'if [[ -z "$1" ]]; then' >> "$BIN_DIR/alma"
echo '    echo "Usage: alma <input.alma>"' >> "$BIN_DIR/alma"
echo '    exit 1' >> "$BIN_DIR/alma"
echo 'fi' >> "$BIN_DIR/alma"
echo 'OUTPUT_JS="/tmp/temp_output.js"' >> "$BIN_DIR/alma"
echo 'python3 "$TRANSPILER" "$1" "$OUTPUT_JS"' >> "$BIN_DIR/alma"
echo 'if [[ $? -eq 0 ]]; then' >> "$BIN_DIR/alma"
echo '    "$NODE" "$OUTPUT_JS"' >> "$BIN_DIR/alma"
echo 'else' >> "$BIN_DIR/alma"
echo '    echo "❌ Error during transpilation."' >> "$BIN_DIR/alma"
echo '    exit 1' >> "$BIN_DIR/alma"
echo 'fi' >> "$BIN_DIR/alma"

# Make the script executable
chmod +x "$BIN_DIR/alma"

# Update PATH if necessary
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$SHELL_CONFIG"
    export PATH="$BIN_DIR:$PATH"
fi

echo "✅ Alma installed successfully on macOS! Run 'alma -v' to test."
