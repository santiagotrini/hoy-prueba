.data
nl: .asciiz "\n"

.text
main:
  lw $a0, 4($a1)
  jal atoi
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

atoi:
  addi $sp, $sp, -8
  sw $s0, 0($sp)
  sw $s1, 4($sp)
  li $v0, 0
atoi_loop:
  lb $s0, 0($a0)
  beq $s0, $zero, ret
  mul $v0, $v0, 10
  addi $s1, $s0, -48
  add $v0, $v0, $s1
  addi $a0, $a0, 1
  j atoi_loop
ret:
  lw $s0, 0($sp)
  lw $s1, 4($sp)
  addi $sp, $sp, 8
  jr $ra
