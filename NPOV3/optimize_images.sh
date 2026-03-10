#!/bin/bash
# Скрипт для оптимизации изображений на macOS (конвертация в WebP)
# Использование: ./optimize_images.sh

echo "Converting PNG and JPG files to WebP..."

for file in *.png *.jpg *.jpeg; do
    if [ -f "$file" ]; then
        filename=$(basename -- "$file")
        extension="${filename##*.}"
        filename="${filename%.*}"
        
        # Using cwebp if installed, otherwise falling back to sips (macOS 11+)
        if command -v cwebp &> /dev/null; then
            cwebp -q 80 "$file" -o "${filename}.webp"
            echo "Converted $file to ${filename}.webp using cwebp"
        else
            sips -s format webp "$file" --out "${filename}.webp"
            echo "Converted $file to ${filename}.webp using sips"
        fi
    fi
done

echo "Done! Make sure to update your HTML/CSS references to use the new .webp files."
