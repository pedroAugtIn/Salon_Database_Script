#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~Pedro's Salon~~~~\n"

MAIN_MENU(){
  echo -e "How may I help you?\n"
  echo -e "1) Hair Cut\n2) Massage\n3) Hair Coloring\n4) Exit"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
  1) HAIR_CUT_MENU;;
  2) MASSAGE_MENU;;
  3) HAIR_COLORING;;
  4) EXIT;;
  *) MAIN_MENU;;
  esac
}

HAIR_CUT_MENU(){
  #get customer info
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
  # get new customer name
  echo -e "\nWhat's your name?"
  read CUSTOMER_NAME
  # get customer time
  echo -e "\nWhat time would you like to schedule?"
  read SERVICE_TIME
  # insert new customer
  INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  # get new customer 
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")
  echo -e "\nI have put you down for a hair cut at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}
MASSAGE_MENU(){
  echo Massage
}
HAIR_COLORING(){
  echo Hair Coloring
}
EXIT(){
  echo Thank you for your visit.
}


MAIN_MENU
