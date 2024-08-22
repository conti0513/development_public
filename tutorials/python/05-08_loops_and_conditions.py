print("----------\nQ5\n----------")
# Q5. Basics of the for loop
# Use a for loop to print the numbers from 1 to 10

for i in range(1, 11):
    print(i)

print("----------\nQ6\n----------")
# Q6. Basics of the for loop 2
# Use a for loop to print the numbers from 35 to 46

for i in range(35, 47):
    print(i)

print("----------\nQ7\n----------")
# Q7. Combination of for loop and conditionals
# Print only the odd numbers between 40 and 50

for i in range(40, 51):
    if i % 2 == 1:  # Applied Modification 1
        print(i)

print("----------\nQ8\n----------")
# Q8. Combination of for loop and conditionals 2
# Print only the multiples of 3 between 10 and 25

for i in range(10, 26):
    if i % 3 == 0:  # Applied Modification 2
        print(i, type(i))

print("----------")
