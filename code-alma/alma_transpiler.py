import sys
import re

VERSION = "1.4"  # <-- Ide írd a verziót!

if len(sys.argv) == 2 and sys.argv[1] in ("-v", "--version"):
    print(f"Alma Language v{VERSION}")
    sys.exit(0)

def transpile_alma_to_js(alma_file, output_file):
    try:
        with open(alma_file, 'r', encoding='utf-8') as f:
            alma_code = f.read()

        # Regular expressions for replacements
        replacements = {
            r'\beat\b': 'let',
            r'\bmake eat\b': 'const',
            r'\balma\b': 'function',
            r'\bfood\(': 'console.log(',
            r'\bfin\b': 'return',
            r'\bate\b': 'if',
            r';;;': ';',
            r';;': ';'
        }

        # Function to replace only outside of quotes
        def replace_outside_quotes(match):
            text = match.group(0)
            for pattern, replacement in replacements.items():
                text = re.sub(pattern, replacement, text)
            return text

        # Replace only outside of quotes
        js_code = re.sub(r'(?:"[^"]*"|\'[^\']*\'|`[^`]*`)|[^"\'`]+', replace_outside_quotes, alma_code)

        # Save the transformed code to the output file
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(js_code)
        
    except Exception as e:
        print(f"Error in translation: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python alma_transpiler.py input.alma output.js")
        sys.exit(1)

    transpile_alma_to_js(sys.argv[1], sys.argv[2])