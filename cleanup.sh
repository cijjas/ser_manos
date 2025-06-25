#!/usr/bin/env bash
# project_cleanup.sh – Cleanup and static fixes for Grupo 3 Flutter project

set -euo pipefail

echo "Eliminando archivos innecesarios todo.txt preguntas.txt..."
for f in todo.txt preguntas.txt; do
  find . -type f -name "$f" -exec echo "Eliminando archivo innecesario: {}" \; -delete
done

echo "Configurando sed compatible..."
if sed --version >/dev/null 2>&1; then
  # GNU sed (Linux)
  SED_CMD=("sed" "-i" "-E")
else
  # BSD sed (macOS)
  SED_CMD=("sed" "-i" "" "-E")
fi

echo "Aplicando fixes con dart fix (imports duplicados, const, etc.)..."
dart fix --apply

echo "Eliminando prints en archivos Dart..."
find lib test -type f -name "*.dart" -print0 |
while IFS= read -r -d '' file; do

  # Borra la línea completa si *solo* tiene un print(...)
  sed -i.bak -E \
    '/^[[:space:]]*print[[:space:]]*\(.*\)[[:space:]]*;[[:space:]]*(\/\/.*)?$/d' "$file"

  # Elimina prints en linea
  sed -i.bak -E \
    's/[[:space:]]*print[[:space:]]*\([^;]*\)[[:space:]]*;[[:space:]]*(\/\/.*)?//g' "$file"

  rm "$file.bak" 2>/dev/null
  echo " Procesado: $file"
done
#
#echo "Eliminando todos los comentarios en archivos Dart..."
#find lib -type f -name "*.dart" -print0 | while IFS= read -r -d '' file; do
#  "${SED_CMD[@]}" '
#    s/\/\/.*$//g
#    s/\/\*[^*]*\*+([^/*][^*]*\*+)*\///g
#  ' "$file"
#done
#
