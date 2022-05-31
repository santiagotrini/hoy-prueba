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
test_output_spim() {
  output=$(echo $1 | $2)
  expected=$3
  if [[ "$output" == "$expected" ]]
  then
    echo -e "[  ${GREEN}OK${NC}  ]: echo $1 | $2 → $3 ${GREEN}✓${NC}"
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

# 1_factorial
test_output "./factorial 4" "24"
test_output "./factorial 5" "120"
test_output "./factorial 6" "720"
# 2_factorial_args
test_output "spim -q -f factorial_args.s 4" "24"
test_output "spim -q -f factorial_args.s 5" "120"
test_output "spim -q -f factorial_args.s 6" "720"
# 3_factorial_stdin
test_output_spim "4" "spim -q -f factorial.s" "24"
test_output_spim "5" "spim -q -f factorial.s" "120"
test_output_spim "6" "spim -q -f factorial.s" "720"
# 4_circulos
test_pjava "circulos" "1" "circulos1.png"
test_pjava "circulos" "2" "circulos2.png"
test_pjava "circulos" "4" "circulos4.png"

# resultado final
echo "--------------  Resultado  --------------"
if [[ $tests_passed -eq 12 ]]
then
  echo -e "Todos los tests pasaron ${GREEN}✓${NC}"
else
  echo "Resultado: $tests_passed/12 tests OK."
fi

exit 0
