This is a ruby implementation of the secret santa problem.

After researching I realized the problem has many variants and multiple approaches to solutions.

I have used a simple approach to solve the problem.

#Approach:

  - Create 2 lists of participants, one recievers the other senders.
  - Corresponding indexes give each others give, so person at position i in senders will give gift to person at position i in recievers
  - Check to see if the current solution is valid
      - no one is giving themselves a gift
      - no one is giving gift to their partner
      - no one is giving gift to the same person they gave it to last time
  - if the solution is not valid, randomly shuffle the senders and try again



This approach does not cater for the case when their is no solution, it will just keep on trying forever. I have tried to focus on the design and clean code rather than trying to capture all boundry cases.