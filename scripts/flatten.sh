#!/bin/bash

# Set default output directory to "out" if not specified
OUTPUT_DIR="${1:-out}"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Show what we'll exclude - only use a minimal set of exclusions
echo "Will exclude: $OUTPUT_DIR/, node_modules/, .git/, vendor/, and some common binary/generated files"

# Find all files, excluding only the most important directories
# This approach uses find's built-in exclusion which is more reliable
echo "Finding files to copy..."
FILES_TO_COPY=$(find . \
    -type f \
    -not -path "./$OUTPUT_DIflatten.shR/*" \
    -not -path "*/node_modules/*" \
    -not -path "*/.git/*" \
    -not -path "*/vendor/*" \
    -not -path "*/tmp/*" \
    -not -path "*/build/*" \
    -not -path "*/dist/*" \
    -not -path "*/.idea/*" \
    -not -path "*/.vscode/*" \
    -not -path "*/coverage/*" \
    -not -name "*.exe" \
    -not -name "*.dll" \
    -not -name "*.so" \
    -not -name "*.dylib" \
    -not -name "*.o" \
    -not -name "*.a" \
    -not -name "*.test" \
    -not -name "*.out" \
    -not -name ".DS_Store" \
    -not -name ".env*" \
    -not -name "*.log")

# Count total files to copy
TOTAL_FILES=$(echo "$FILES_TO_COPY" | wc -l)
echo "Found $TOTAL_FILES files to copy"

# Show sample of files that will be copied (up to 5)
echo "Sample files that will be copied:"
echo "$FILES_TO_COPY" | head -5

# Copy all files
echo "Copying files from current directory to '$OUTPUT_DIR'..."

echo "$FILES_TO_COPY" | while read file; do
    # Skip if the file is empty or the output directory itself
    if [ -z "$file" ] || [[ "$file" == "./$OUTPUT_DIR/"* ]]; then
        continue
    fi

    # Get the filename without the path
    filename=$(basename "$file")

    # Always copy the file, replacing if it already exists
    cp "$file" "$OUTPUT_DIR/"
    echo "Copied: $file to $OUTPUT_DIR/$filename"
done

echo "Operation complete. All files have been flattened and copied to '$OUTPUT_DIR'"
