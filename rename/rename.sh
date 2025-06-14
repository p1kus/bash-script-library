echo "Enter output prefix, result file: {prefix}.{extension}: "
read prefix
fileCount=1
case "$extension" in
"jpg" | "jpeg") echo "its jpg" ;;
"png") echo "its png" ;;
esac
for f in ./*; do
  echo "$f"
  extension="${f##*.}"
  echo "Processing #$fileCount $f file..."
  case "$extension" in
  "jpg")
    mv -- "$f" "$prefix-$fileCount.jpg"
    ((fileCount++))
    ;;
  "png")
    mv -- "$f" "$prefix-$fileCount.png"
    ((fileCount++))
    ;;
  esac
done
