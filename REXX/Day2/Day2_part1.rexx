/* REXX */
/* Solution for Advent of code 2024 Day 2*/
/* given an input file, read in each line*/
/* determine if each line is safe*/
/*saftey is determined ib both senerios are true */
/*numbers in sequqnce on a line all either increase or decrease*/
/* and adjacent numbers differ by atleast 1 and at most 3*/

/* i think there are at most 8 variables in a line*/
/* so that will be my working area*/

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
    inLine.i.5 inLine.i.6 inLine.i.7 inLine.i.8
end






/* now i need 3 functions.*/
/* all takes 2 values and the previous boolean (default true)*/
/*first one checks to see if values are increasing*/
/*second one sees if values are defreasin*/
/*third checks to see if values are at least 1 and less than 3*/
/* if 1 or both values are empty, default to the last boolean*/
/*one of the first two and the adjacent level boolesan must be tru to be safe*/

/*end program*/
exit


/* takes 3 values, 2 vars and a boolean value*/
/*if the boolean is already false, return the boolean */
/*if 1 or mare vars are empty, return the boolean*/
/*if both vars are less than 3 and at leat 1, and boolean is not false*/
/* then return true.*/
checkAdj: Arg boolVal inVar1 inVar2
    if boolVal=FALSE then return boolVal
    if inVar1='' then return boolVal
    if inVar2='' then return boolVal
    maxVal=max(inVar1,inVar2)
    minVal=min(inVar1,inVar2)
    diff=maxVal-minVal
    if diff >=1 & diff <=3 then return TRUE
    else return FALSE
