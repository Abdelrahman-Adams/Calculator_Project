#!/bin/bash

#This function check if the input is decimal number ( not text nor out of decimal range )
function text_error(){
if [[ "$num" =~ ^[0-9]+?$ ]]
then
	echo "decimal";dec
else  
	echo "error"	#whiptail --title "Result" --msgbox "NOT Decimal" 8 78
   	num_sys
	#return 1
fi
dec
}
function validation(){
if [ $num -eq 0 && $value -eq 1 ]; then
    echo "valid number"
    return 0
    break
else
    echo "not valid number, try again"
    return 1
fi
}

#This function check if second number is zero 0 when divide by 0
function check_second_number(){
if [ "$num" = 0 ]
then
    echo "The number is zero"
else
    echo "number not zero"
fi
}

#This function check if input number is binary
function check_binary_number(){
if [[ "$num" =~ ^[0-1]+?$ ]]
then
	echo "binary"; bin 
else
	echo "not binary"; whiptail --title "Result" --msgbox "not binary" 8 78

fi
}

#This function check if input number is octal
function check_octal_number(){
if [[ "$num" =~ ^[0-7]+?$ ]]
then
    echo "oct accepted";oct
else
    echo "not octal";num_sys
	
fi
}

#This function check if input number is hexa
function check_hexa_number(){
if [[ "$num" =~ ^[0-9A-Fa-f]+?$ ]]
then
	echo "hex accept";hex
else
	echo "not hexa";num_sys
fi
}

##################################################################
#save  string in seprated binary + convert binary to decimal# 
##################################################################

function bin(){
#echo "$num"
count=${#num}-1
w=${#num}

for ((i=$count;i>=0;i--)); do bin="$bin${num:$i:1}"; done
while [ "$w" != "0" ]
do
	for (( i =0; i<=count; i++))
	do
		((d${i}=${bin:i:1}))
		w=$((w - 1))
		dold=$((d$i))*$((2**$i))
		dec=$((dec + dold))
		doct=$dec; dhex=$dec
	done
##########################
#convert decimal to octal#
##########################
	while [ $doct != 0 ]
	do	
		orem=$(($doct% 8))
		octal="$octal${orem}"
		doct=$((doct / 8))	
	done	
########################
#convert decimal to hex#
########I################
	while [ $dhex != 0 ]
	do
		hrem=$(($dhex% 16))
		if [ "$hrem" -gt "9" ]
		then
			char=( {A..F} ) ; n=( {10..15} )
			for ((i=0; i<6;i++))
			do
				if [ "$hrem" == "${n[i]}" ]; then hrem=${char[i]}; fi
			done
		fi
		xhex=$xhex$hrem
		rev_hex=$(echo $xhex | rev)
		dhex=$((dhex / 16))
		
	done
done
if [[ "$oper" -eq "0" ]]
then
	whiptail --title "Result" --msgbox "binary = $num ,decimal = $dec ,octal = $(rev<<<"${octal}"),hex = $rev_hex" 8 78
else
	whiptail --title "Result" --msgbox "binary = $num ,decimal = $dec ,octal = $(rev<<<"${octal}"),hex = $rev_hex" 8 78
	oper=0
	scientific_fun
fi
#echo "binary = $num ,decimal = $dec ,octal = $(rev<<<"${octal}"),hex = $rev_hex"
}
###########################
#convert decimal to binary#
###########################
function dec()
{
bin=0
while [ $num != 0 ]
do
	brem=$(($num% 2))
	bin="$bin${brem}"
	num=$((num / 2))
done
num=$(echo $bin |rev)
echo "dec fun  $num"
if [ "$oper" == "0" ]
then
	bin
else
#	num=$(echo $bin |rev)
	echo "if  $num"
	scientific_in
fi
}
#########################
#convert octal to decimal#
#########################
function oct()
{
ndec=0
count=${#num}-1
w=${#num}
for ((i=$count;i>=0;i--)); do oct="$oct${num:$i:1}"; done  #reverse the input
while [ "$w" != "0" ]
do
	for (( i=0 ; i<=count ; i++ ))
	do
		dig_oct=${oct:i:1}
		odec=$((dig_oct * (8**$i)))
		ndec=$((ndec + odec))
		w=$((w - 1))
	done

done
num=$ndec
dec
}
#########################
#convert hexa to decimal#
#########################
function hex()
{
ndec=o
count=${#num}-1
w=${#num}

for ((i=$count;i>=0;i--)); do hex="$hex${num:$i:1}"; done
while [ "$w" != "0" ]
do
	for (( i =0; i<=count; i++))
	do
		w=$((w - 1))
		element=${hex:i:1}
		case ${element} in
			[0-9])  element=$element ;;
			a|A) element=10 ;;
			b|B) element=11 ;;
			c|C) element=12 ;;
        		d|D) element=13 ;;
        		e|E) element=14 ;;
        		f|F) element=15 ;;
       			*) echo "invalid" ;;
		esac
		odec=$((element))*$((16**$i))
		ndec=$((ndec+odec))
	done
done
num=$ndec
dec
}

##########################################


#R_Shift Funcrion#
function r_shift(){
	   # ADD_F=$(whiptail --inputbox "enter the number:" 8 39  --title "ADD" 3>&1 1>&2 2>&3)
           # ADD_S=$(whiptail --inputbox "enter the shift value:" 8 39  --title "ADD" 3>&1 1>&2 2>&3)
           # ADD_R=$((ADD_F + ADD_S))
           # whiptail --title "result of ADD" --msgbox  "the result of $ADD_F + $ADD_S = $ADD_R" 8 78	
	num1=$(whiptail --inputbox "Enter the Number" 10 50 --title "R_Shift" 3>&1 1>&2 2>&3)
        num2=$(whiptail --inputbox "Enter the shift value" 10 50 --title "R_Shift" 3>&1 1>&2 2>&3)
        if [ "$num1" -eq "$num1" ] && [ "$num2" -eq "$num2" ]; then
	s=`echo $(($num1 >> $num2))`
        whiptail --title "R_Shift Result" --msgbox "$num1 >> $num2 = $s" 7 40
        scientific_fun
        else
        whiptail --title "R_Shift ERROR!" --msgbox "Please Enter Valid Input" 10 50
        r_shift
        fi	
}

#L_Shift Function#
function l_shift(){
	
	num1=$(whiptail --inputbox "Enter the Number" 10 50 --title "L_Shift" 3>&1 1>&2 2>&3)
        num2=$(whiptail --inputbox "Enter the shift value" 10 50 --title "L_Shift" 3>&1 1>&2 2>&3)
        if [ "$num1" -eq "$num1" ] && [ "$num2" -eq "$num2" ]; then
        s=`echo $(($num1 << $num2))`
        whiptail --title "L_Shift Result" --msgbox "$num1 << $num2 = $s" 7 40
        scientific_fun
        else
        whiptail --title "L_Shift ERROR!" --msgbox "Please Enter Valid Input" 10 50
        l_shift
        fi	
}

#AND Function#
function and(){
	
	num1=$(whiptail --inputbox "Enter Number1" 10 50 --title "AND" 3>&1 1>&2 2>&3)
        num2=$(whiptail --inputbox "Enter Number2" 10 50 --title "AND" 3>&1 1>&2 2>&3)
        #echo "$num1 $num2"
	if [ "$num1" -eq "$num1" ] && [ "$num2" -eq "$num2" ]; then
	num=$((num1 & $num2))
        whiptail --title "AND Result" --msgbox "$num1 [AND] $num2 = $num" 7 40
        scientific_fun
        else
        whiptail --title "AND ERROR!" --msgbox "Please Enter Valid Input" 10 50
        and
        fi
		
}

#OR Function#
function or(){
	
	num1=$(whiptail --inputbox "Enter Number1" 10 50 --title "OR" 3>&1 1>&2 2>&3)
        num2=$(whiptail --inputbox "Enter Number2" 10 50 --title "OR" 3>&1 1>&2 2>&3)
        if [ "$num1" -eq "$num1" ] && [ "$num2" -eq "$num2" ]; then
        s=$(($num1 | $num2))
        whiptail --title "OR Result" --msgbox "$num1 [OR] $num2 = $s" 7 40
        scientific_fun
        else
        whiptail --title "OR ERROR!" --msgbox "Please Enter Valid Input" 10 50
        or
        fi
	
}

#XOR Function#
function xor(){
	
	num1=$(whiptail --inputbox "Enter Number1" 10 50 --title "XOR" 3>&1 1>&2 2>&3)
        num2=$(whiptail --inputbox "Enter Number2" 10 50 --title "XOR" 3>&1 1>&2 2>&3)
        if [ "$num1" -eq "$num1" ] && [ "$num2" -eq "$num2" ]; then
        s=$(($num1 ^ $num2))
        whiptail --title "XOR Result" --msgbox "$num1 [XOR] $num2 = $s" 7 40
        scientific_fun
        else
        whiptail --title "XOR ERROR!" --msgbox "Please Enter Valid Input" 10 50
        xor
        fi
	
}

#NOT Function#
function not(){
	
	num1=$(whiptail --inputbox "Enter Number1" 10 50 --title "NOT" 3>&1 1>&2 2>&3)
        if [ "$num1" -eq "$num1" ]; then
        s=$((~$num1))
	whiptail --title "Result" --msgbox "NOT($num1) = $s" 7 40
        scientific_fun
        else
        whiptail --title "ERROR!" --msgbox "Please Enter Valid Input" 10 50
        not
        fi	
}
#############################################
function scientific_in()
{
if [ "${oper}" ==  "not" ];then num1=$num ; ${oper}
else
	if [[ $num1 =~ ^[0-9]+$ ]]
	then
		num2=$num
		echo "$num1 XXXX $num2"
		${oper}
		else
		num1=$num;
		num_sys
	fi
fi
}

##############################################
####################################################
function scientific_fun(){

#oper=0
choose=$(whiptail --title "Scientific" --menu "\nChoose an Operation:" --cancel-button Back 15 60 6 \
"1" "Right Shift" \
"2" "Left Shift" \
"3" "AND" \
"4" "OR" \
"5" "XOR" \
"6" "NOT" 3>&1 1>&2 2>&3)
case $choose in
        1) oper="r_shift"; r_shift ;; #make a variable calling the function
        2) oper="l_shift"; l_shift ;;
        3) oper="and"; and ;;
        4) oper="or"; or ;;
        5) oper="xor"; xor ;;
        6) oper="not"; not ;;
        *) calc_opr; ;;
esac
#${oper}  #calling the function which in the vairableI
}
#############################################################
function num_sys()
{
#num=0
option=$(whiptail --title "calculator_project" --menu "Choose an option" 18 50 10 \
     "1)" " Binary " \
     "2)" " Decimal " \
     "3)" " Octal " \
     "4)" " Hexadecimal "  3>&1 1>&2 2>&3
        )
	case $option in

         	"1)") r_shift ;;
         	#num=$(whiptail --inputbox "Enter the number " 18 50 --title "" 3>&1 1>&2 2>&3); 
		"2)") num=$(whiptail --inputbox "Enter the number " 18 50 --title "" 3>&1 1>&2 2>&3); text_error ;;
        	"3)") num=$(whiptail --inputbox "Enter the number " 18 50 --title "" 3>&1 1>&2 2>&3); check_octal_number ;;
         	"4)") num=$(whiptail --inputbox "Enter the number " 18 50 --title "" 3>&1 1>&2 2>&3); check_hexa_number ;;

     	esac
}







# #this function to message team members
function TEAM {
 team_members="Ahmed Elsayed Mohamed Anwar
Abdelrahman Abdelmonem Elbezawy 
Abdelrahman Elsayed Farouk
Ahmed Mohamed Saad Mousa 
Mohamed Maher Kamel Shehab  "
 whiptail --title  "team members" --msgbox --fb    "$team_members" 15 40

 if [[ $? == 0 ]] ; then
	 M
 else
	 echo "select ok "
 fi
 }

# #this function for documentaion
function DOC_M {
Documentation="this project was made by hard working team in ITI System Admin track Aswan 
branch  under the supervisoin of Eng.Karim Abd Elhamid 
big thanks for ITI for this big experince and special thanks for Eng.Karim for sharing his
experince with us and his great effort that helped us to compelete this project

this project is about a calculator with bash scripting language.
the main menu contains:
1) calculator      :this will open an another menu to choose the mode of calculator.
     *1) standard
     *2) programmer
     *3) scientific
     *4) back'main menu'  :for back to main menu

 if you choose the standard mode that will open an another menu
 to choose the standard operation
       1) ADD                   :this for addition operation.
       2) SUB                   :this for subtraction operation.
       3) MUL                   :this for multiplication operation.
       4) DIV                   :this for division operation.
	   5) EXPO                  :this for exponential operation.
	   6) back to previous menu :this back to calculator menu.
	   7) back to main menu     :this back to main menu.

 if you choose the programmer mode that will open an another menu
 to choose the programmer operation.

 1) binary
 2) decimal
 3) octal
 4) hexdecimal

 that is to convert from (1-4) to all of them.

 if you choose the scientific mode that will open an another menu
 to choose the scientific operation.

1) right shift
2) left shift
3) AND
4) OR
5) XOR
6) NOT

*that is take a decimal input
#########################################################################
#########################################################################
2) Documentation   :this descripe the Documentation of the project.
3) team members    :this show the team members names.
4) EXIT            :this to EXIT from the program "
 
 whiptail --title  "documentation" --msgbox --fb --scrolltext   "$Documentation" 30 80

 if [[ $? == 0 ]] ; then
	 M
 else
	 echo "select ok "
 fi
}



#this function for standard arthimatic opreration
function STD_R {
standard=$(whiptail --title "standard-calculator" --menu "Choose an option" 18 50 10 \
     "1)" "ADD" \
     "2)" "SUB" \
     "3)" "MUL" \
     "4)" "DIV" \
	 "5)" "EXPO" \
	 "6)" "back to previous menu" \
	 "7)" "back to main menu"  3>&1 1>&2 2>&3
 	)

 case $standard in
 	    "1)") 
            ADD_F=$(whiptail --inputbox "enter the first number:" 8 39  --title "ADD" 3>&1 1>&2 2>&3)
            ADD_S=$(whiptail --inputbox "enter the second number:" 8 39  --title "ADD" 3>&1 1>&2 2>&3)
            ADD_R=$(echo "$ADD_F+$ADD_S" | bc)
            whiptail --title "result of ADD" --msgbox  "the result of $ADD_F + $ADD_S = $ADD_R" 8 78
        
         ;;
	        
	
         "2)")   
	    SUB_F=$(whiptail --inputbox "enter the first number:" 8 39  --title "SUB" 3>&1 1>&2 2>&3)
            SUB_S=$(whiptail --inputbox "enter the second number:" 8 39  --title "SUB" 3>&1 1>&2 2>&3)
            SUB_R=$(echo "$SUB_F-$SUB_S" | bc)
            whiptail --title "result of ADD" --msgbox "the result of $SUB_F - $SUB_S = $SUB_R" 8 78

         ;;

 	    "3)")  
            MUL_F=$(whiptail --inputbox "enter the first number:" 8 39  --title "MUL" 3>&1 1>&2 2>&3)
            MUL_S=$(whiptail --inputbox "enter the second number:" 8 39  --title "MUL" 3>&1 1>&2 2>&3)
            MUL_R=$(echo "scale=20;$MUL_F*$MUL_S" | bc)
            whiptail --title "result of MUL" --msgbox "the result of $MUL_F * $MUL_S = $MUL_R" 8 78
        
         ;;

		 "4)")  
            DIV_F=$(whiptail --inputbox "enter the first number:" 8 39  --title "DIV" 3>&1 1>&2 2>&3)
            DIV_S=$(whiptail --inputbox "enter the second number:" 8 39  --title "DIV" 3>&1 1>&2 2>&3)
            DIV_R=$(echo "scale=20;$DIV_F/$DIV_S" | bc)
            whiptail --title "result of DIV" --msgbox "the result of $DIV_F / $DIV_S = $DIV_R" 8 78
        
         ;;

		 "5)")  
       
            # value of A
  a=$(whiptail --inputbox "enter the first number:" 8 39  --title "DIV" 3>&1 1>&2 2>&3)

  # value of B
  b=$(whiptail --inputbox "enter the second number:" 8 39  --title "DIV" 3>&1 1>&2 2>&3)

  # c to count counter
  c=1

  # res to store the result
  res=1

  #
  if ((b==0));
  then
    res=1
  fi

  if ((a==0));
  then
    res=0
  fi

  if ((a >= 1 && b >= 1));
  then
    while((c <= b))
    do
      res=$((res * a))
c=$((c + 1))
    done
  fi
 whiptail --title "result of EXPO" --msgbox "the result of $a ** $b = $res" 8 78

         ;;

		 "6)") 
		  
		  CALC

         ;;

         "7)") 
          
		  M  

 	    ;;

	  
     esac
     if [[ $? == 0 ]] ; then
	 CALC
 else
	 echo "select ok "
 fi

 }


 #this function for scirntific opreration
function SCIEN {
scientific=$(whiptail --title "scientific-calculator" --menu "Choose an option" 18 50 10 \
     "1)" "AND" \
     "2)" "OR" \
     "3)" "NOR" \
     "4)" "NAND" \
	 "5)" "NOT" \
     "6)" "XOR" \
     "7)" "XNOR" \
	 "8)" "back to previous menu" \
	 "9)" "back to main menu"  3>&1 1>&2 2>&3
 	)

 case $scientific in
 	    "1)") 
            ADD_F=$(whiptail --inputbox "enter the first number:" 8 39  --title "ADD" 3>&1 1>&2 2>&3)
            ADD_S=$(whiptail --inputbox "enter the second number:" 8 39  --title "ADD" 3>&1 1>&2 2>&3)
            ADD_R=$((ADD_F + ADD_S))
            whiptail --title "result of ADD" --msgbox  "the result of $ADD_F + $ADD_S = $ADD_R" 8 78
        
         ;;
	        
	
         "2)")   
	        SUB_F=$(whiptail --inputbox "enter the first number:" 8 39  --title "SUB" 3>&1 1>&2 2>&3)
            SUB_S=$(whiptail --inputbox "enter the second number:" 8 39  --title "SUB" 3>&1 1>&2 2>&3)
            SUB_R=$((SUB_F - SUB_S))
            whiptail --title "result of ADD" --msgbox "the result of $SUB_F - $SUB_S = $SUB_R" 8 78

         ;;

 	    "3)")  
            MUL_F=$(whiptail --inputbox "enter the first number:" 8 39  --title "MUL" 3>&1 1>&2 2>&3)
            MUL_S=$(whiptail --inputbox "enter the second number:" 8 39  --title "MUL" 3>&1 1>&2 2>&3)
            MUL_R=$((MUL_F * MUL_S))
            whiptail --title "result of MUL" --msgbox "the result of $MUL_F * $MUL_S = $MUL_R" 8 78
        
         ;;

		 "4)")  
            DIV_F=$(whiptail --inputbox "enter the first number:" 8 39  --title "DIV" 3>&1 1>&2 2>&3)
            DIV_S=$(whiptail --inputbox "enter the second number:" 8 39  --title "DIV" 3>&1 1>&2 2>&3)
            DIV_R=$((DIV_F / DIV_S))
            whiptail --title "result of DIV" --msgbox "the result of $DIV_F / $DIV_S = $DIV_R" 8 78
        
         ;;

		 "5)")  
       
            EXPO_F=$(whiptail --inputbox "enter the number:" 8 39  --title "exponentiation" 3>&1 1>&2 2>&3)
            EXPO_S=$(whiptail --inputbox "enter the exponentiation number:" 8 39  --title "exponentiation" 3>&1 1>&2 2>&3)
            EXPO_R=$((EXPO_F ** EXPO_S))
            whiptail --title "result of EXPO" --msgbox "the result of $EXPO_F ** $EXPO_S = $EXPO_R" 8 78
         ;;

		 "6)") 
		  
		  CALC

         ;;

         "7)") 
          
		  M  

 	    ;;

	  
     esac
     if [[ $? == 0 ]] ; then
	 CALC
 else
	 echo "select ok "
 fi

 }

 


#this function for calculator menu modes

function CALC {
calculator=$(whiptail --title "calculator" --menu "Choose an option" 18 50 10 \
     "1)" "standard" \
     "2)" "programmer" \
     "3)" "scientific" \
     "4)" "back to main menu"  3>&1 1>&2 2>&3
 	)

 case $calculator in
 	    "1)") 
          
			STD_R
         ;;
	        
	
         "2)")   
	       
            PROG
         ;;
 	    "3)")  
       		 scientific_fun
        
         ;;
         "4)") 
		 #back to main menu
          M       
 	    ;;

	  
     esac

     if [[ $? == 0 ]] ; then
	 M
 else
	 echo "select ok "
 fi

 }




##################################################################
#save  string in seprated binary + convert binary to decimal# 
##################################################################

function bin(){
count=${#num}-1
w=${#num}

for ((i=$count;i>=0;i--)); do bin="$bin${num:$i:1}"; done
while [ "$w" != "0" ]
do
	for (( i =0; i<=count; i++))
	do
		((d${i}=${bin:i:1}))
		w=$((w - 1))
		dold=$((d$i))*$((2**$i))
		dec=$((dec + dold))
		doct=$dec; dhex=$dec
	done
##########################
#convert decimal to octal#
##########################
	while [ $doct != 0 ]
	do	
		orem=$(($doct% 8))
		octal="$octal${orem}"
		doct=$((doct / 8))	
	done	
########################
#convert decimal to hex#
########I################
	while [ $dhex != 0 ]
	do
		hrem=$(($dhex% 16))
		if [ "$hrem" -gt "9" ]
		then
			char=( {A..F} ) ; n=( {10..15} )
			for ((i=0; i<6;i++))
			do
				if [ "$hrem" == "${n[i]}" ]; then hrem=${char[i]}; fi
			done
		fi
		xhex=$xhex$hrem
		rev_hex=$(echo $xhex | rev)
		dhex=$((dhex / 16))
	done
done
whiptail --title "Result" --msgbox "binary = $num ,decimal = $dec ,octal = $(rev<<<"${octal}"),hex = $rev_hex" 8 78
#echo "binary = $num ,decimal = $dec ,octal = $(rev<<<"${octal}"),hex = $rev_hex"
}
###########################
#convert decimal to binary#
###########################
function dec()
{
while [ $num != 0 ]
do
	brem=$(($num% 2))
	bin="$bin${brem}"
	num=$((num / 2))
done
num=$(echo $bin |rev)
bin
}
#########################
#convert octal to decimal#
#########################
function oct()
{
count=${#num}-1
w=${#num}
for ((i=$count;i>=0;i--)); do oct="$oct${num:$i:1}"; done  #reverse the input
while [ "$w" != "0" ]
do
	for (( i=0 ; i<=count ; i++ ))
	do
		dig_oct=${oct:i:1}
		odec=$((dig_oct * (8**$i)))
		ndec=$((ndec + odec))
		w=$((w - 1))
	done

done
num=$ndec
dec
}
#########################
#convert hexa to decimal#
#########################
function hex()
{
count=${#num}-1
w=${#num}

for ((i=$count;i>=0;i--)); do hex="$hex${num:$i:1}"; done
while [ "$w" != "0" ]
do
	for (( i =0; i<=count; i++))
	do
		w=$((w - 1))
		element=${hex:i:1}
		case ${element} in
			[0-9])  element=$element ;;
			a|A) element=10 ;;
			b|B) element=11 ;;
			c|C) element=12 ;;
        		d|D) element=13 ;;
        		e|E) element=14 ;;
        		f|F) element=15 ;;
       			*) echo "invalid" ;;
		esac
		odec=$((element))*$((16**$i))
		ndec=$((ndec+odec))
	done
done
num=$ndec
dec
}

 function PROG () {
   option=$(whiptail --title "calculator_project" --menu "Choose an option" 18 50 10 \
     "1)" " Binary " \
     "2)" " Decimal " \
     "3)" " Octal " \
     "4)" " Hexadecimal "  3>&1 1>&2 2>&3
        )

 case $option in

         "1)") num=$(whiptail --inputbox "Enter the number " 18 50 --title "" 3>&1 1>&2 2>&3); bin ;;
         "2)") num=$(whiptail --inputbox "Enter the number " 18 50 --title "" 3>&1 1>&2 2>&3);  dec ;;
         "3)") num=$(whiptail --inputbox "Enter the number " 18 50 --title "" 3>&1 1>&2 2>&3); oct ;;
         "4)") num=$(whiptail --inputbox "Enter the number " 18 50 --title "" 3>&1 1>&2 2>&3); hex ;;

     esac


 }
 #this function for main menu
function M {
opt=$(whiptail --title "calculator_project" --menu "Choose an option" 18 50 10 \
     "1)" "calculator" \
     "2)" "Documentation" \
     "3)" "team members" \
     "4)" "EXIT"  3>&1 1>&2 2>&3
 	)

 case $opt in
 	    "1)") 
          
			CALC
         ;;
	        
	
         "2)")   
	      
		   DOC_M

         ;;
 	    "3)")  
       
			TEAM
         ;;
         "4)") 
          exit       
 	    ;;

	  
     esac

 }

M
#STANDARD