csrrw t2, 0xf00, zero

lui t1, 104857
addi t1, t1, 2047 # 0.1 in 32,32 constant
addi t1, t1, 411

#addi t2, zero, 1854 # 32,0 FP dummy variable 1468
addi t6, zero, 10 # constant 10


# registers
# t1 : constant 0.1
# t2: input val dummy variable
# t6: constant 10
# s1: mulhu final register
# s2: output reg

# HEX0 
mulhu  t3, t2, t1 # 0.1 x 1468 = 146
mul t4, t2, t1 # 0.1 x 1468 = .8
mulhu s1, t4, t6 # hex0 = .8 * 10 = 8
add s2, zero, s1

# HEX1
mulhu t5, t3, t1 # 0.1 x 146 = 14
mul t4, t3, t1 # 0.1 x 146 = .6
mulhu s1, t4, t6 # hex1 = .6 x 10 = 6
slli s1, s1, 4
or s2, s1, s2

# HEX2
mulhu t2, t5, t1 # 0.1 x 14 = 1
mul a1, t5, t1 # 0.1 x 14 = .4
mulhu s1, a1, t6 # .4 x 10 = 4
slli s1, s1, 8
or s2, s1, s2

# HEX3
mulhu t3, t2, t1 # 0.1 x 1 = 0
mul a2, t2, t1 # 0.1 x 1 = .1
mulhu s1, a2, t6 # 0.1 x 10 = 1
slli s1, s1, 12
or s2, s1, s2

# HEX4
mulhu t5, t3, t1 # 0.1 x 0 = 0
mul a1, t3, t1 # 0.1 x 0 = 0
mulhu s1, a1, t6 # 0 x 10 = 0
slli s1, s1, 16
or s2, s1, s2

# HEX5
mulhu t4, t5, t1 # 0.1 x 0 = 0
mul t3, t5, t1 # 0.1 x 0 = 0
mulhu s1, t3, t6 # 0 x 10 = 0
slli s1, s1, 20
or s2, s1, s2

# HEX6
mulhu t2, t4, t1 # 0.1 x 0 = 0
mul t5, t4, t1 # 0.1 x 0 = 0
mulhu s1, t5, t6 # 0 x 10 = 0
slli s1, s1, 24
or s2, s1, s2

# HEX7
mulhu t3, t2, t1 # 0.1 x 0 = 0
mul a1, t2, t1 # 0.1 x 0 = 0
mulhu s1, a1, t6 # 0 x 10 = 0
slli s1, s1, 28
or s2, s1, s2

csrrw s1, 0xf02, s2










