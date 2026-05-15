# You can change these values to test your solution.
.data
ARRAY: .word -6 -1 6 1
SIZE:  .word 4

.text
main:
  la a1, ARRAY        # a1 = pointer to array
  lw a2, SIZE         # a2 = number of elements in the array
  jal ra, argmax      # call argmax function
exit:
  li a7, 10           # exit syscall code
  ecall               # terminate the program

# ==========================================================================
# FUNCTION: argmax
#   Takes an array of integers and returns the index of the largest element.
#   If there are multiple elements with the same maximum value, 
#   it should return the smallest index among them.
# Arguments:
#   a1 = pointer to int array
#   a2 = array length
# Returns:
#   a0 = status code
#   a1 = index of the largest element
# ===========================================================================
argmax:

#PSEUDO CODIGO:
#argmax(a1: int*, a2: int) -> (a0: int, a1: int):
#
#  se a2 < 1:
#    retorna (50, indefinido)
#
#  max_idx = 0
#  max_val = A[0]
#
#  para i de 0 até a2 - 1:
#    se A[i] > max_val:
#      max_val = A[i]
#      max_idx = i
#
#  retorna (0, max_idx)



  # t0 = índice atual (i = 0)
  # t1 = índice do máximo atual (max_idx = 0)
  # t2 = valor do máximo atual (max_val = A[0])
  # t3 = endereço temporário
  # x2 (stack pointer) equivale ao speudo registo sp
  # ra (return address) equivale ao resgistro x1


  # save da ra na stack
  addi x2, x2, -4
  sw ra, 0(x2)

  # Validação do tamanho < 1: erro 50
  li t0, 1
  blt a2, t0, Erro50

  li t0, 0
  li t1, 0
  lw t2, 0(a1)          # max_val = A[0]

loop:
  # para se i >= tamanho
  bge t0, a2, Passa

  # Calculo dp endereço de A[i]: offset = i * 4
  slli t3, t0, 2        # t3 = i << 2
  add t3, a1, t3        # t3 = base + offset
  lw t4, 0(t3)          # t4 = A[i]

  # Se A[i] <= max_val, não atualiza (garante menor índice em empate)
  ble t4, t2, proximo

  # Novo máximo encontrado
  mv t2, t4             # max_val = A[i]
  mv t1, t0             # max_idx = i

proximo:
  addi t0, t0, 1        # i++
  j loop

Passa:
  li a0, 0              # código de sucesso
  mv a1, t1             # índice do maior elemento
  j argmax_end

Erro50:
  li a0, 50             # código de erro: argumento inválido
  j argmax_end

argmax_end:
  # load ra e retorna
  lw ra, 0(x2)
  addi x2, x2, 4
  jr ra     # return to the caller