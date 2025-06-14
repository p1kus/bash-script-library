#!bin/bash

letterArr=({a..z} {A..Z})
numArr=({0..9})
charArr=('!' '@' '#' '$' '%' '^' '&' '*')
hyphen="-"

passwordLength=24

password=""

for ((i = 0; i < passwordLength; i++)); do
  rand=$((RANDOM % (${#letterArr[@]} - 0 + 1) + 0))
  password+=${letterArr[rand]}
  if [ $i -eq 8 ]; then
    password+=${hyphen}
  elif [ $i -eq 16 ]; then
    password+=${hyphen}
  fi

done

if [[ ! "$password" =~ [0-9] ]]; then
  password="${password%?}"
  password+=$((RANDOM % (${#numArr[@]} - 0 + 1) + 0))
fi

echo "${password}"

# echo "${letterArr[@]}"
# echo "${numArr[@]}"
# echo "${charArr[@]}"
# echo "$hyphen"
# echo "$rand"
