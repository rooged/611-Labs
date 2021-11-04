csrrw t2, 0xf00, x9

lui t1, 104857
addi t1, t1, 2047 # 0.1 in 32,32 constant
addi t1, t1, 411

addi t2, zero, 1852 # 32,0 FP dummy variable 1468
addi t6, zero, 10 # constant 10


# registers
# t1 : constant 0.1
# t2: input val dummy variable
# t6: constant 10
# s1: hex0
# s2: hex1
# s3: hex2
# s4: hex3
# s5: hex4
# s6: hex5
# s7: hex6
# s8: hex7
#

# HEX0 
mulhu  t3, t2, t1 # 0.1 x 1468 = 146
mul t4, t2, t1 # 0.1 x 1468 = .8
mulhu s1, t4, t6 # hex0 = .8 * 10 = 8
csrrw x1, 0xf02,s1

# HEX1
mulhu t5, t3, t1 # 0.1 x 146 = 14
mul t4, t3, t1 # 0.1 x 146 = .6
mulhu s2, t4, t6 # hex1 = .6 x 10 = 6 
csrrw x2, 0xf02,s2

# HEX2
mulhu t2, t5, t1 # 0.1 x 14 = 1
mul a1, t5, t1 # 0.1 x 14 = .4
mulhu s3, a1, t6 # .4 x 10 = 4
csrrw x3, 0xf02,s3

# HEX3
mulhu t3, t2, t1 # 0.1 x 1 = 0
mul a2, t2, t1 # 0.1 x 1 = .1
mulhu s4, a2, t6 # 0.1 x 10 = 1
csrrw x4, 0xf02,s4

# HEX4
mulhu t5, t3, t1 # 0.1 x 0 = 0
mul a1, t3, t1 # 0.1 x 0 = 0
mulhu s5, a1, t6 # 0 x 10 = 0
csrrw x5, 0xf02,s5

# HEX5
mulhu t4, t5, t1 # 0.1 x 0 = 0
mul t3, t5, t1 # 0.1 x 0 = 0
mulhu s6, t3, t6 # 0 x 10 = 0
csrrw x6, 0xf02,s6

# HEX6
mulhu t2, t4, t1 # 0.1 x 0 = 0
mul t5, t4, t1 # 0.1 x 0 = 0
mulhu s7, t5, t6 # 0 x 10 = 0
csrrw x7, 0xf02,s7

# HEX7
mulhu t3, t2, t1 # 0.1 x 0 = 0
mul a1, t2, t1 # 0.1 x 0 = 0
mulhu s8, a1, t6 # 0 x 10 = 0
csrrw x8, 0xf02,s8










