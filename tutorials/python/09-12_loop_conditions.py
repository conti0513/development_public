print("----------\nQ9\n----------")
# Q9.
# The loop iterates through numbers from 20 to 50 and checks
# if they are divisible by 2 and if the result of dividing by 2 is odd. 
# If both conditions are met, the number is printed.
# Start condition: 20 -> End condition: 50, increment by 1
for i in range(20, 51):

    # Check if divisible by 2 and the result of division by 2 is odd
    # Apply Modification 1
    if i % 2 == 0 and (i // 2) % 2 == 1:
        print(i)

print("\n----------\nQ10\n----------")
# Q10. Combination of for loop and conditionals 4
# Count how many numbers between 20 and 50 result in an odd number when divided by 2
# Define an empty variable to count the numbers
count = 0

# Start condition: 20 -> End condition: 50, increment by 1
for i in range(20, 51):
    # Check if divisible by 2 and the result of division by 2 is odd, then increment count
    # Apply Modification 1
    if i % 2 == 0 and (i // 2) % 2 == 1:
        count += 1

# Print the count to confirm the number of such numbers
print(count)

print("\n----------\nQ11\n----------")
# Q11. Calculation using for loop
# Count how many numbers below 1000 are multiples of 3 or 7

# Define an empty variable to count the numbers
count = 0

# Start condition: 1000 -> End condition: 1, decrement by 1
for i in range(1000, 0, -1):
    # If a multiple of 3 or 7, increment count by 1
    # Apply Modification 2 and Modification 3
    if i % 3 == 0 or i % 7 == 0:
        count += 1

# Print the count to confirm the number of such numbers
print(count)

print("\n----------\nQ12\n----------")
# Q12. Calculation using for loop 2
# Find the 5th largest number below 1000 that is a multiple of 3 or 7

# Define an empty variable to count the numbers
count = 0

# Start condition: 1000 -> End condition: 1, decrement by 1
for i in range(1000, 0, -1):
    # If a multiple of 3 or 7, increment count by 1
    # Apply Modification 2 and Modification 3
    if i % 3 == 0 or i % 7 == 0:
        count += 1
    
    # When count reaches 5, print the 5th largest number and exit the loop
    if count == 5:
        # Print the current count (which should be 5)
        print(count)
        # Print the 5th largest number
        print(i)
        # Exit the loop
        break

print("----------")
