/* REXX */
/* Solution for Advent of code 2024 Day 2*/
/* given an input file, read in each line*/
/* determine if each line is safe*/
/*saftey is determined ib both senerios are true */
/*numbers in sequqnce on a line all either increase or decrease*/
/* and adjacent numbers differ by atleast 1 and at most 3*/

/* i think there are at most 8 variables in a line*/
/* i'll work with 9 just in case*/


/*Part 2. anow allow for reports with a single bad level and count those*/
/*as safe as well*/

totalSafeReports=0

/*read input file*/
inFile='input.txt'
/*open the input file*/
call linein inFile, 1, 0
/* read in the variables*/
do i=1 while lines(inFile)\==0
    inLine.i=linein(inFile)
    inLine.0=i
end
/*close the input file*/
call lineout inFile


/* check each line for saftey.*/
/* parse the input line*/

do i=1 to inLine.0 by 1
    /*reset vars knowing some may be empty on the line */
    parse var inLine.i inLine.i.1 inLine.i.2 inLine.i.3 inLine.i.4,
    inLine.i.5 inLine.i.6 inLine.i.7 inLine.i.8 inLine.i.9 inLine.i.10


    /*iterate through all lines. test if chexkAdj and if either increase or */
    /* decrease are safe, if so. increase totalSafeReports by 1*/
    adjVal='TRUE'
    increaseVal='TRUE'
    decreaseVal='TRUE'
    badAdjCount=0
    badAdjLoc=''
    badIncCount=0
    badIncLoc=''
    badDecCount=0
    badDecLoc=''
    do j=1 to 10 by 1
        k=j+1
        L=j+2
        call checkAdj(adjVal inLine.i.j inLine.i.k)
        adjVal = RESULT
        call checkIncrease(increaseVal inLine.i.j inLine.i.k)
        increaseVal=RESULT
        call checkDecrease(decreaseVal inLine.i.j inLine.i.k)
        decreaseVal=RESULT
    /*check to see if allowing 1 bad value will make the output pass*/
        /*adjacent*/
        if (badAdjCount<1 & adjVal='FALSE') then
        do
            badAdjCount=badAdjCount+1
            badAdjLoc=j
            call checkAdj('TRUE' inLine.i.k inLine.i.L)
            adjVal = RESULT
        end
        else nop
        /*increase*/
        if (badIncCount<1 & increaseVal='FALSE') then
        do
            badIncCount=badIncCount+1
            badIncLoc=j
            call checkIncrease('TRUE' inLine.i.k inLine.i.L)
            increaseVal = RESULT
        end
        else nop
        /*decrease*/
        if (badDecCount<1 & decreaseVal='FALSE') then
        do
            badDecCount=badDecCount+1
            badDecLoc=j
            call checkDecrease('TRUE' inLine.i.k inLine.i.L)
            decreaseVal = RESULT
        end
        else nop
    end
    /* allow for a single flaw in a report*/
    if decreaseVal='TRUE' & adjVal='TRUE' then
    do
        if badAdjCount+badDecCount<2 then totalSafeReports=totalSafeReports+1
        if badAdjCount+badDecCount=3 & badAdjLoc=badDecLoc then 
        do
            totalSafeReports=totalSafeReports+1
        end
        else nop
    end
    else nop
    if increaseVal='TRUE' & adjVal='TRUE' then
    do
        if badAdjCount+badIncCount<2 then totalSafeReports=totalSafeReports+1
        if badAdjCount+badIncCount=3 & badAdjLoc=badIncLoc then 
        do
            totalSafeReports=totalSafeReports+1
        end
        else nop
    end
    else nop
 

end

say 'Total safe reports: ' totalSafeReports



/*end program*/
exit


/*subroutines*/

/* takes 3 values, 2 vars and a boolean value*/
/*if the boolean is already false, return the boolean */
/*if 1 or more are vars are empty, return the boolean*/
/*if both vars are less than 3 and at leat 1, and boolean is not false*/
/* then return true.*/
checkAdj: Arg boolVal inVar1 inVar2
    if boolVal='FALSE' then return boolVal
    if inVar1='' then return boolVal
    if inVar2='' then return boolVal
    maxVal=max(inVar1,inVar2)
    minVal=min(inVar1,inVar2)
    diff=maxVal-minVal
    if diff >=1 & diff <=3 then return 'TRUE'
    else return 'FALSE'

/* takes 3 values, 2 vars and a boolean value*/
/*if the boolean is already false, return the boolean */
/*if 1 or more are vars are empty, return the boolean*/
/*if the second var is greater than the first, and boolean is not false*/
/* then return true.*/
checkIncrease: Arg boolVal inVar1 inVar2
    if boolVal='FALSE' then return boolVal
    if inVar1='' then return boolVal
    if inVar2='' then return boolVal
    if inVar2>inVar1 then return 'TRUE'
    else return 'FALSE'

/* takes 3 values, 2 vars and a boolean value*/
/*if the boolean is already false, return the boolean */
/*if 1 or mmoreare vars are empty, return the boolean*/
/*if the second var is smaller than the first, and boolean is not false*/
/* then return true.*/
checkDecrease: Arg boolVal inVar1 inVar2
    if boolVal='FALSE' then return boolVal
    if inVar1='' then return boolVal
    if inVar2='' then return boolVal
    if inVar2<inVar1 then return 'TRUE'
    else return 'FALSE'




/* i'm a bit stuck. i think i know why. i don't know if femoving the first*/
/* element or the scond element will fix it. so i need to be able to test both*/