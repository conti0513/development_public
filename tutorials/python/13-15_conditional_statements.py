print("----------\nQ13\n----------")
# Q13. Conditional Statement
# Declare two integer variables.
# Write a conditional statement that outputs "It's even", "It's odd", or "It's 0" based on whether the result of subtracting the second number from the first is even, odd, or zero.

num1 = 11
num2 = 11

# Store the result in diff and ensure it is an integer
diff = num1 - num2
print(diff)  # No need for var_dump in Python; print suffices

# Add condition for when diff is 0
if diff == 0:
    print("It's 0")
elif diff % 2 == 1:
    print("It's odd")
elif diff % 2 == 0:
    print("It's even")

print("----------\nQ14\n----------")

# Q14. FizzBuzz
# Loop through numbers 1 to 100.
# For multiples of 3, print "Fizz", for multiples of 5, print "Buzz",
# and for multiples of both 3 and 5, print "FizzBuzz".

for i in range(1, 101):
    if i % 15 == 0:
        print("FizzBuzz")
    elif i % 3 == 0:
        print("Fizz")
    elif i % 5 == 0:
        print("Buzz")
    else:
        print(i)

print("----------\nQ15\n----------")

# Q15. Switch Statement Equivalent in Python
# Declare two integer variables.
# Write a conditional statement that outputs "It's even", "It's odd", or "It's 0" based on whether the result of subtracting the second number from the first is even, odd, or zero.

num1 = 11
num2 = 11

# Store the result in diff and ensure it is an integer
diff = num1 - num2
print(diff)  # No need for var_dump in Python; print suffices

# In Python, switch-case is typically done using if-elif-else

if diff == 0:  # Modification 5: Handling when diff is 0
    print("It's 0")
elif diff % 2 == 1:  # Checking for odd
    print("It's odd")
elif diff % 2 == 0:  # Checking for even
    print("It's even")
