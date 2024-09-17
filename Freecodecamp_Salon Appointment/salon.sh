#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n ~~~~~~ POGING SALON ~~~~~~~ \n"
MAIN_MENU() {
  if [[ $1 ]]
then
  echo -e "\n$1"
fi
  echo "Welcome Pogi! What services do you want?"

  echo -e "\n1) Haircut\n2) Manicure\n3) Pedicure"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
  1) HAIRCUT ;;
  2) MANICURE ;;
  3) PEDICURE ;;
  *) MAIN_MENU "I don't do that. Sorry." ;;
  esac
}
HAIRCUT(){
  SERVICE_NAME=$($PSQL "select name from services where service_id =$SERVICE_ID_SELECTED")
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone ='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_ID ]]
  then
  echo -e "\nI don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  INSERT_NAME=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone ='$CUSTOMER_PHONE'")
  else
  CUSTOMER_NAME=$($PSQL "select name from customers where customer_id =$CUSTOMER_ID")
  fi
  echo -e "\nWhat time would you like your cut, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?"
  read SERVICE_TIME
  echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed -r 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(CUSTOMER_ID,service_id,time) VALUES ($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
}
MANICURE(){
    SERVICE_NAME=$($PSQL "select name from services where service_id =$SERVICE_ID_SELECTED")
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone ='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_ID ]]
  then
  echo -e "\nI don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  INSERT_NAME=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone ='$CUSTOMER_PHONE'")
  else
  CUSTOMER_NAME=$($PSQL "select name from customers where customer_id =$CUSTOMER_ID")
  fi
  echo -e "\nWhat time would you like your cut, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?"
  read SERVICE_TIME
  echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed -r 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(CUSTOMER_ID,service_id,time) VALUES ($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
}
PEDICURE(){
    SERVICE_NAME=$($PSQL "select name from services where service_id =$SERVICE_ID_SELECTED")
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone ='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_ID ]]
  then
  echo -e "\nI don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  INSERT_NAME=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone ='$CUSTOMER_PHONE'")
  else
  CUSTOMER_NAME=$($PSQL "select name from customers where customer_id =$CUSTOMER_ID")
  fi
  echo -e "\nWhat time would you like your cut, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?"
  read SERVICE_TIME
  echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed -r 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(CUSTOMER_ID,service_id,time) VALUES ($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
}
MAIN_MENU