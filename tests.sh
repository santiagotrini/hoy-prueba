#!/bin/bash

# colores
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# contador
tests_passed=0

# funciones
test_output() {
  output=$($1)
  expected=$2
  if [[ "$output" == "$expected" ]]
  then
    echo -e "[  ${GREEN}OK${NC}  ]: $1 → $2 ${GREEN}✓${NC}"
    tests_passed=$((tests_passed + 1))
  else
    echo -e "[ ${RED}Fail${NC} ]: Esperaba '$expected' pero se obtuvo '$output' ${RED}✗${NC}"
  fi
}
test_output_ml() {
  output=$($1)
  expected=$2
  if [[ "$output" == "$expected" ]]
  then
    echo -e "[  ${GREEN}OK${NC}  ]: $1 ${GREEN}✓${NC}"
    tests_passed=$((tests_passed + 1))
  else
    echo -e "[ ${RED}Fail${NC} ]: $1 ${RED}✗${NC}"
  fi
}
test_pjava() {
  cd $1
  args=$2
  expected=$3
  processing-java --sketch=$PWD --run $2 > /dev/null
  diff $1.png $3 > /dev/null
  if [[ $? == 0 ]]
  then
    echo -e "[  ${GREEN}OK${NC}  ]: $1 $2 ${GREEN}✓${NC}"
    tests_passed=$((tests_passed + 1))
  else
    echo -e "[ ${RED}Fail${NC} ]: $1 $2 ${RED}✗${NC}"
  fi
  cd ..
}

# 1_fibonacci
test_output "./fibonacci 4" "0 1 1 2 "
test_output "./fibonacci 7" "0 1 1 2 3 5 8 "
test_output "./fibonacci 1" "Error"
test_output "./fibonacci 10" "0 1 1 2 3 5 8 13 21 34 "
test_output "./fibonacci 12" "0 1 1 2 3 5 8 13 21 34 55 89 "
test_output "./fibonacci 15" "0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 "
test_output "./fibonacci 6" "0 1 1 2 3 5 "
test_output "./fibonacci 8" "0 1 1 2 3 5 8 13 "
test_output "./fibonacci -1" "Error"
test_output "./fibonacci 0" "Error"
# 2_pintas
test_output "./pintas 0" "Error"
test_output "./pintas 1" "1.00"
test_output "./pintas 3" "1.75"
test_output "./pintas 100" "2.00"
test_output "./pintas -1" "Error"
test_output "./pintas 2" "1.50"
test_output "./pintas 8" "1.99"
test_output "./pintas 7" "1.98"
test_output "./pintas 10" "2.00"
test_output "./pintas -10" "Error"
# 3_circulos
test_pjava "circulos" "1" "circulos1.png"
test_pjava "circulos" "2" "circulos2.png"
test_pjava "circulos" "4" "circulos4.png"
test_pjava "circulos" "5" "circulos5.png"
test_pjava "circulos" "8" "circulos8.png"
test_pjava "circulos" "10" "circulos10.png"
test_pjava "circulos" "16" "circulos16.png"
test_pjava "circulos" "20" "circulos20.png"
test_pjava "circulos" "25" "circulos25.png"
test_pjava "circulos" "40" "circulos40.png"

# resultado final
echo "--------------  Resultado  --------------"
if [[ $tests_passed -eq 30 ]]
then
  echo -e "Todos los tests pasaron ${GREEN}✓${NC}"
else
  echo "Resultado: $tests_passed/30 tests OK."
fi
exit 0
