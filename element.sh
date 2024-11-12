#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [ -z $1 ] 
  then
    echo "Please provide an element as an argument."
    exit 0
  else
    INPUT=$1

    if [[ "$INPUT" =~ ^[0-9]+$ ]]
    then
      RESULT=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = '$INPUT' LIMIT 1;")
    else
      RESULT=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$INPUT' OR symbol = '$INPUT' LIMIT 1;")
    fi

    if [ -z "$RESULT" ] 
      then
      echo "I could not find that element in the database."
      else
        ATOMIC_NUMBER=$RESULT
        NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER;")
        SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER;")
        ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER;")
        MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER;")
        BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER;")

        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a nonmetal, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
fi

