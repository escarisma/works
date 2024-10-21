#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "Enter your username:"
read username

# Check if the username already exists
USERID=$($PSQL "SELECT user_id FROM users WHERE username='$username'")

if [[ -z $USERID ]]; then
    # Insert new user
    INSERTUSER=$($PSQL "INSERT INTO users(username, games_plyed, best_game_guesses) VALUES('$username', 0, 0)")
    echo "Welcome, $username! It looks like this is your first time here."
    USERID=$($PSQL "SELECT user_id FROM users WHERE username='$username'")
    games_plyed=0
    best_game=0
else
    # Fetch existing user data
    games_plyed=$($PSQL "SELECT games_plyed FROM users WHERE username='$username'")
    best_game=$($PSQL "SELECT best_game_guesses FROM users WHERE username='$username'")
    echo "Welcome back, $username! You have played $games_plyed games, and your best game took $best_game guesses."
fi

RANDOM_NUMBER=$((RANDOM % 1000 + 1))
GUESSCOUNT=0
GUESS=0

echo "Guess the secret number between 1 and 1000:"

while [[ $GUESS != $RANDOM_NUMBER ]]; do
    read USERGUESS
    if [[ $USERGUESS =~ ^[0-9]+$ ]]; then
        GUESS=$USERGUESS
        ((GUESSCOUNT++))
        
        if [[ $GUESS -gt $RANDOM_NUMBER ]]; then
            echo "It's lower than that, guess again:"
        elif [[ $GUESS -lt $RANDOM_NUMBER ]]; then
            echo "It's higher than that, guess again:"
        else
            echo "You guessed it in $GUESSCOUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"
        fi
    else
        echo "That is not an integer, guess again:"
    fi
done

# Update games played
((games_plyed++))

# Update best game guesses if applicable
if [[ $best_game -eq 0 || $GUESSCOUNT -lt $best_game ]]; then
    UPDATEBESTGAME=$($PSQL "UPDATE users SET best_game_guesses=$GUESSCOUNT WHERE user_id=$USERID")
fi

# Update total games played
UPDATEGAMESPLAYED=$($PSQL "UPDATE users SET games_plyed=$games_plyed WHERE user_id=$USERID")
