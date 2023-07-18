# UserEvidence Challenge Solution: Slot Machine
My approach to this challenge goes beyond simply writing code. I have carefully analyzed the problem, made strategic decisions, and implemented effective problem-solving tactics. The goal is not only to meet the challenge requirements but to exceed expectations through innovative thinking and execution.

To gain a complete understanding of the problem and my proposed solution, please refer to the original instructions provided by UserEvidence. Your feedback is highly valuable to me, as I am eager to refine my approach based on your input.

Let's dive into the details and explore the solution together!

# UserEvidence Slot Machine

Welcome to the UserEvidence Slot Machine! This is a simple full-stack app that simulates a slot machine game.

## Prerequisites

Before running the application, please ensure that you have the following dependencies installed:

- Docker
- PostgreSQL 14

## Getting Started

To get started with the UserEvidence Slot Machine, please follow the steps below:

1. Clone this repository to your local machine.

2. Navigate to the project directory.

3. Open the `config/database.yml` file and add the necessary credentials for connecting to your PostgreSQL database. Update the `username` and `password` fields with your database credentials.

4. Build the Docker image by running the following command:

   ```shell
   docker-compose build
   ```

5. Start the container by running the following command:

   ```shell
   docker-compose up
   ```
## Running Tests

To run the tests for the UserEvidence Slot Machine, follow these steps:

1. Ensure that the Docker containers are running.

2. Open a new terminal window and navigate to the project directory.

3. Run the following command to execute the tests:

   ```shell
   docker-compose run web bundle exec rspec
   ```
## Shutting Down

To stop and shut down the Docker containers, press Ctrl + C in the terminal where they are running. Then, run the following command to stop and remove the containers:

   ```shell
   docker-compose down
   ```

## Please note that before using the app, you need to create a user account by signing up from the login page.

# Original Instructions
### Objective

Jackpot! You've landed a summer gig in Las Vegas! Unfortunately, it's 2020, and the casinos are closed due to COVID-19. Your boss wants to move some of the business online and asks you to build a full-stack app — a simple slot machine game, with a little twist. Build it to ensure that the house always wins!

### Brief

When a player starts a game/session, they are allocated 10 credits.
Pulling the machine lever (rolling the slots) costs 1 credit.
The game screen has 1 row with 3 blocks.
For players to win the roll, they have to get the same symbol in each block.
There are 4 possible symbols: cherry (10 credits reward), lemon (20 credits reward), orange (30 credits reward), and watermelon (40 credits reward).
The game (session) state has to be kept on the server.
If the player keeps winning, they can play forever, but the house has something to say about that...
There is a CASH OUT button on the screen, but there's a twist there as well.

### Tasks
- Implement the assignment using any language or framework you feel comfortable with
- When a user opens the app, a session is created on the server, and they have 10 starting credits.
