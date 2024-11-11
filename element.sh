#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"
echo "Please provide an element as an argument."
read ELEMENT

if [[ -z $1 ]]
  then
    echo -e "\n$ELEMENT"
  fi