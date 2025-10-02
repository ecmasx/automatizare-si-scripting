#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Eroare: Calea catre directorul care trebuie curatat este necesara"
    exit 1
fi

dir="$1"
shift

if [ ! -d "$dir" ]; then
    echo "Eroare: Directorul '$dir' nu exista"
    exit 1
fi

extensions=("${*}")
if [ ${#extensions[*]} -eq 0 ]; then
    extensions=(".tmp")
fi

count=0
for ext in "${extensions[*]}"; do
    if [[ ! "$ext" =~ ^\. ]]; then
        ext=".$ext"
    fi
    
    while IFS= read -r -d '' file; do
        rm "$file" && ((count++))
    done < <(find "$dir" -type f -name "*$ext" -print0)
done

echo "Eliminate $count fisiere"
