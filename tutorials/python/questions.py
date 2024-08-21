# Q1
print("----------\nQ1\n----------")  # Modification 3
# 1. Basic variable declarations
# Declare variables with the following values:
# - Integer $number: 5
# - String $text: "test"
# - Boolean $flag: True
# - None type $test: None

# Declare variables
number = 5
text = "test"
flag = True
test = None

# Output variables to confirm
print(number)
print(text)
print(flag)
print(test)
print("----------")

# Confirm variable types
print(type(number))
print(type(text))
print(type(flag))
print(type(test))

print("----------\nQ2\n----------") 
# Q2. Basic calculations
# Declare two integer variables.
# Use these variables to output the result of addition, subtraction, multiplication, division, and remainder.

int_num1 = 9
int_num2 = 5

# Addition
print(int_num1 + int_num2)
print(type(int_num1 + int_num2))

# Subtraction
print(int_num1 - int_num2)
print(type(int_num1 - int_num2))

# Multiplication
print(int_num1 * int_num2)
print(type(int_num1 * int_num2))

# Division
print(int_num1 / int_num2)
print(type(int_num1 / int_num2))

# Remainder
print(int_num1 % int_num2)
print(type(int_num1 % int_num2))

print("----------\nQ3\n----------")
# Q3. Conditional statements and boolean
# Declare a boolean variable initialized to False.
# If the sum of the two variables from Q2 is even, set the boolean variable to True.

# Declare variable
flag = False

# Q3 process
# Apply modification 5
if (int_num1 + int_num2) % 2 == 0:
    flag = True

# Output the flag state to confirm
print(flag)

print("----------\nQ4\n----------")
# Q4. Conditional statement
# Use the boolean variable from Q3 in a conditional statement and output the following:
# - If even, print "It's even"
# - If odd, print "It's odd"

# Q4 process
# Apply modification 1 to 4 (combine questions, combine processing, add spaces around operators, remove unnecessary else, use \n for new lines)
# Apply modification 5 (adjust to receive the result from Q3)
# Apply modification 6 (correct comparison operator issue)
if flag:
    print("It's even")
else:
    print("It's odd")

print("----------")
