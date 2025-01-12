import sys

def transpile_alma_to_js(alma_file, output_file):
    try:
        with open(alma_file, 'r', encoding='utf-8') as f:
            alma_code = f.read()

        # Konvertálások az ALMA nyelvről JavaScript-re
        js_code = alma_code
        js_code = js_code.replace("eat ", "let ")
        js_code = js_code.replace("make eat ", "const")
        js_code = js_code.replace("alma", "function")
        js_code = js_code.replace("food(", "console.log(")
        js_code = js_code.replace("fin", "return")
        js_code = js_code.replace("ate", "if")
        js_code = js_code.replace(";;;", ";")
        js_code = js_code.replace(";;", ";")

        # Az átalakított kód mentése a temp_output.js fájlba
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(js_code)
        
        print(f"Transpiled {alma_file} to {output_file}.")
    except Exception as e:
        print(f"Error in translation: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python alma_transpiler.py input.alma output.js")
        sys.exit(1)

    transpile_alma_to_js(sys.argv[1], sys.argv[2])
