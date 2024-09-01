#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams, games")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WIN_GOALS LOSE_GOALS
do
#remove headers
if [[ $OPPONENT != opponent ]]
then
TEAM1=$($PSQL "select name from teams where name = '$OPPONENT'")
  if [[ -z $TEAM1 ]]
  then 
  #clecho $OPPONENT
  INSERT_TEAM1=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
  echo $INSERT_TEAM1
  fi
    TEAM2=$($PSQL "select name from teams where name = '$WINNER'")
    if [[ -z $TEAM2 ]]
    then
    INSERT_TEAM2=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
    echo $INSERT_TEAM1
    fi
WIN_ID=$($PSQL "select team_id from teams where name='$WINNER'")
LOSE_ID=$($PSQL "select team_id from teams where name='$OPPONENT'")
INSERT_GAME=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WIN_ID,$LOSE_ID,$WIN_GOALS,$LOSE_GOALS)")
echo $INSERT_GAME
fi
done
   