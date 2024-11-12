
.globl str_ge, recCheck

.data

maria:    .string "Maria"
markos:   .string "Markos"
marios:   .string "Marios"
marianna: .string "Marianna"

.align 4  # make sure the string arrays are aligned to words (easier to see in ripes memory view)

# These are string arrays
# The labels below are replaced by the respective addresses
arraySorted:    .word maria, marianna, marios, markos

arrayNotSorted: .word marianna, markos, maria

.text

            la   a0, arrayNotSorted
            li   a1, 4
            jal  recCheck

            li   a7, 10
            ecall

str_ge:
#---------
# Write the subroutine code here
lbu  t0, 0(a0)
            lbu  t1, 0(a1)
            sub  t2, t0,   t1  # result: 0 if equal,
                               # >0 if char @a0 "higher", <0 if char @a1 "higher"
            addi a0, a0,   1
            addi a1, a1,   1
            add  t3, t1,   t0  # if the sum is equal to either one, one must be 0
            beq  t3, t0,   ret_strcmp  # any string finished, leave
            # I could have compared each of t0, t1 to zero. Still 2 instructions (beq's)
            beq  t2, zero, str_ge  #still equal, loop
ret_strcmp:
            srli a0, t2, 31  # get the sign bit. If 1, negative, so strictly less
            xori a0, a0, 1 # Invert it. So a0 is 1 if greater or equal.
            
#  You may move jr ra   if you wish.
#---------
            jr   ra
 
# ----------------------------------------------------------------------------
# recCheck(array, size)
# if size == 0 or size == 1
#     return 1
# if str_ge(array[1], array[0])      # if first two items in ascending order,
#     return recCheck(&(array[1]), size-1)  # check from 2nd element onwards
# else
#     return 0

recCheck:
#---------
# Write the subroutine code here
#  You may move jr ra   if you wish.
#---------
            jr   ra
