#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^-?[0-9]+$ ]]
  then
  AtomicNum=$1
  SymbolName='NA'
  else
  SymbolName=$1
  AtomicNum=00
  fi
MAIN_MENU()
{ 
AtomicNumber=$($PSQL "select atomic_number from elements where atomic_number = $AtomicNum OR symbol = '$SymbolName' OR name = '$SymbolName'")
  if [[ -z $AtomicNumber ]]
  then echo "I could not find that element in the database."
  else
  #The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
  ElementData=$($PSQL "select name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius from elements join properties ON elements.atomic_number = properties.atomic_number JOIN types ON properties.type_id = types.type_id  where elements.atomic_number = $AtomicNumber")
  IFS='|' read -ra fields <<< "$ElementData"
  Ename="${fields[0]}"
  Esymbol="${fields[1]}"
  Etype="${fields[2]}"
  Eatomic_mass="${fields[3]}"
  Emelting="${fields[4]}"
  Eboiling="${fields[5]}"
  echo "The element with atomic number $AtomicNumber is $Ename ($Esymbol). It's a $Etype, with a mass of $Eatomic_mass amu. $Ename has a melting point of $Emelting celsius and a boiling point of $Eboiling celsius."
  fi
}
MAIN_MENU
fi

