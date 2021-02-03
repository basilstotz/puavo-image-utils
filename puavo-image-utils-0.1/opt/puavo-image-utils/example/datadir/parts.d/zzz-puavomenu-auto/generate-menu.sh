#!/bin/sh

cd $(dirname $0)


if test -f /tmp/applications.list;then
    ALT=$(cat /tmp/applications.list|xargs)
else
    exit 0
fi

DIFF=""
for A in $(ls /usr/share/applications/*.desktop);do
    A=$(basename -s .desktop $A)
    if echo $ALT|grep -q -v $A;then
	DIFF="$DIFF $A"
    fi
done


#alles start
echo "{"

#programms start
echo "  \"programs\": {"
FIRST_P=0
for A in $DIFF;do
	 if test $FIRST_P = 0;then
	     FIRST_P=1
	 else
	     echo ","
	 fi	
         echo "        \"$A\": {"
         echo "            \"tags\": \"default\""
         echo -n "         }"
done

echo        
echo -n "   }"
#programms ende

#categorie start
FIRST_A=0
echo ","
echo "  \"categories\": {"
echo "     \"category-devel\": {"
echo "        \"name\":  \"Neue Programme\","
echo "        \"position\": 10,"
#echo "        \"hidden_by_default\": true,"

#programm array start
echo "        \"programs\": ["
FIRST_P=0
for A in $DIFF;do
	 if test $FIRST_P = 0;then
	     FIRST_P=1
	 else
	     echo ","
	 fi	
         echo -n "          \"$A\""
done
echo 
echo "        ]"
# programm array ende
echo "     }"
echo "  }"
# categories ende

echo "}"
#alles ende
