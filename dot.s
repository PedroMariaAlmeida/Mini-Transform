# You can change these values to test your solution.
.data
A:    .word 6, 1, 3, 9, 12, 4, 13, 153
B:    .word 6, 1, 3, 9, 12, 4, 13, 153
SIZE: .word 8

.text
main:
  la a1, A          # a1 = pointer to array A
  la a2, B          # a2 = pointer to array B
  lw a3, SIZE       # a3 = number of elements in each array
  jal ra, dot       # call dot function
exit:
  li a7, 10         # exit syscall code
  ecall             # terminate the program


# ==========================================================================
# FUNCTION: dot
#   This function computes the dot product of two integer arrays.
# Arguments:
#   a1 = pointer to first array
#   a2 = pointer to second array
#   a3 = array length
# Returns:
#   a0 = status code
#   a1 = dot product result
# ===========================================================================
dot:

#PSEUDO CODIGO:
# dot(a1: int*, a2: int*, a3: int) -> (a0: int, a1: int):
#
#  se a3 < 1:
#    retorna (50, indefinido)
#
#  acumulador = 0
#
#  para i de 0 até a3 - 1:
#    produto = A[i] * B[i]
#
#    se overflow na multiplicação:
#      retorna (200, indefinido)
#
#    acumulador = acumulador + produto
#
#    se overflow na adição:
#      retorna (200, indefinido)
#
#  retorna (0, acumulador)



# x2 (stack pointer) equivale ao pseudo registo sp
# ra (return address) equivale ao resgisto x1
# t0, t1, t2, t3, t4, t5, t6 são registos temporários 
 # save ra
  addi x2, x2, -4
  sw ra, 0(x2)
  
  # Validação do tamanho < 1
  li t0, 1
  blt a3, t0, invalido
  
  # Iniciação
  li t0, 0              # i = 0
  li t1, 0              # acumulador = 0
  
dot_loop:
  # Condição de paragem
  bge t0, a3, passa
  
  # Calcular offset: offset = i * 4
  slli t2, t0, 2
  
  # Carregar A[i]
  add t3, a1, t2
  lw t3, 0(t3)
  
  # Carregar B[i]
  add t4, a2, t2
  lw t4, 0(t4)
  
  # Multiplicação: t5 = A[i] * B[i]
  mul t5, t3, t4
  
  # DETEÇÃO DE OVERFLOW NA MULTIPLICAÇÃO
  # Verifica se t5 / t4 == t3 (se t4 != 0)
  beqz t4, skip_mul_check    # se B[i] == 0, skip (0*x = 0, sem overflow)
  div t6, t5, t4                 # t6 = t5 / t4
  bne t6, t3, overflow       # se t6 != t3, houve overflow
skip_mul_check:
  
  # Adição com deteção de overflow
  add t6, t1, t5                 # t6 = acumulador + produto
  
  # Verifica overflow na adição:
  # Se t5 > 0 e t6 < t1: overflow positivo
  # Se t5 < 0 e t6 > t1: overflow negativo
  bgtz t5, check_pos_overflow
  bltz t5, check_neg_overflow
  j sem_overflow
  
check_pos_overflow:
  blt t6, t1, overflow       # se resultado < acumulador, overflow
  j sem_overflow
  
check_neg_overflow:
  bgt t6, t1, overflow       # se resultado > acumulador, overflow
  
sem_overflow:
  mv t1, t6                      # atualiza acumulador
  
  # Incrementa índice
  addi t0, t0, 1
  j dot_loop

# sucesso
passa:
  li a0, 0
  mv a1, t1
  j dot_end

#  erro
invalido:
  li a0, 50
  j dot_end

overflow:
  li a0, 200
  j dot_end

#  load ra
dot_end:
  lw ra, 0(x2)
  addi x2, x2, 4
  jr ra