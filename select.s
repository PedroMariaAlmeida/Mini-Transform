# You can change these values to test your solution.
.data
ARRAY: .word -6 -1 6 1
SIZE:  .word 4
INDEX: .word 2

.text
main:
  la a1, ARRAY      # a1 = pointer to array
  lw a2, SIZE       # a2 = array length
  lw a3, INDEX      # a3 = element index
  jal ra, select    # call select function
exit:
  li a7, 10         # exit syscall code
  ecall             # terminate the program

# ==========================================================================
# FUNCTION: select
#   This function selects an element from an integer array.
# Arguments:
#   a1 = pointer to int array
#   a2 = array length
#   a3 = element index
# Returns:
#   a0 = status code
#   a1 = value of the selected element
# ===========================================================================
select:
  # TODO: Implement the select function here

#PSEUDO CODIGO:

#se a2 < 1 : erro 50
#se a3 < 0 : erro 100
#se a3 >= a2 : erro 100
#senão: offset = a3 << 2; endereço = a1 + offset; a1 = lw(endereço); a0 = 0


 # save do ra
  addi x2, x2, -4
  sw ra, 0(x2)
  
  #to e t1 são as variáveis temporárias
  # Validação 1: tamanho < 1
  li t0, 1
  blt a2, t0, error_50
  
  # Validação 2: índice < 0
  blt a3, zero, error_100
  
  # Validação 3: índice >= tamanho
  bge a3, a2, error_100
  
  # Cálculo do offset: offset = index * 4
  slli t1, a3, 2
  add t1, a1, t1 
  
  # Retorno de sucesso
  li a0, 0                    # código de sucesso PRIMEIRO
  lw a1, 0(t1)                # valor do elemento DEPOIS
  j select_end

# erros
error_50:
  li a0, 50
  j select_end

error_100:
  li a0, 100
  j select_end

# load ra e retorna
select_end:
  lw ra, 0(x2)
  addi x2, x2, 4
  jr ra
