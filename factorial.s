.data
nl: .asciiz "\n"

.text
main:
  li $v0, 5
  syscall
  move $s0, $v0 # int n
  li $s1, 1     # int r
  li $s2, 2     # int i
  addi $s0, $s0, 1
loop:
  beq $s0, $s2, exit
  mul $s1, $s1, $s2
  addi $s2, $s2, 1
  j loop
exit:
  li $v0, 1
  move $a0, $s1
  syscall
  li $v0, 4
  la $a0, nl
  syscall
  li $v0, 10
  syscall
