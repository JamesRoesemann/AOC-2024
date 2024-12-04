/* REXX */
/* Solution for Advent of code 2024 Day 2*/
/* given an input file, read in each line*/
/* determine if each line is safe*/
/*saftey is determined ib both senerios are true */
/*numbers in sequqnce on a line all either increase or decrease*/
/* and adjacent numbers differ by atleast 1 and at most 3*/

/* i think there are at most 8 variables in a line*/
/* i'll work with 9 just in case*/


/*Part 2. now allow for reports with a single bad level and count those*/
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

    /*iterate through all lines. test if check adj and if either increase or */
    /* decrease are safe, if so. increase totalSafeReports by 1*/
    tempLine=inLine.i
    call adjTest(tempLine)
    adjVal=result
    call incTest(tempLine)
    increaseVal=result
    call decTest(tempLine)
    decreaseVal=result

    /*if decreaseVal=0 then call decDampaner(tempLine)
    decreaseVal=result
    if increaseVal=0 then call incDampaner(tempLine)
    increaseVal=result
    if adjVal=0 then call adjDampaner(templine)
    adjVal=result*/
 
    if ((decreaseVal=1) | (increaseVal=1)) & adjVal=1 then
    do
        say tempLine
        totalSafeReports=totalSafeReports+1
    end
    else do /*test with dampaner if a failure*/
        currentValid=decreaseVal+decreaseVal+adjVal
        if decreaseVal=0 & currentValid=1 then call decDampaner(tempLine)
        decreaseVal=result
        if increaseVal=0 & currentValid=1 then call incDampaner(tempLine)
        increaseVal=result
        if adjVal=0 & currentValid=1 then call adjDampaner(templine)
        adjVal=result



        if ((decreaseVal=1) | (increaseVal=1)) & adjVal=1 then
        do
            say tempLine
            totalSafeReports=totalSafeReports+1
        end
    end


  

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
    if boolVal=0 then return boolVal
    if inVar1='' then return boolVal
    if inVar2='' then return boolVal
    maxVal=max(inVar1,inVar2)
    minVal=min(inVar1,inVar2)
    diff=maxVal-minVal
    if diff >=1 & diff <=3 then return 1
    else return 0

/* takes 3 values, 2 vars and a boolean value*/
/*if the boolean is already false, return the boolean */
/*if 1 or more are vars are empty, return the boolean*/
/*if the second var is greater than the first, and boolean is not false*/
/* then return true.*/
checkIncrease: Arg boolVal inVar1 inVar2
    if boolVal=0 then return boolVal
    if inVar1='' then return boolVal
    if inVar2='' then return boolVal
    if inVar2>inVar1 then return 1
    else return 0

/* takes 3 values, 2 vars and a boolean value*/
/*if the boolean is already false, return the boolean */
/*if 1 or more vars are empty, return the boolean*/
/*if the second var is smaller than the first, and boolean is not false*/
/* then return true.*/
checkDecrease: Arg boolVal inVar1 inVar2
    if boolVal=0 then return boolVal
    if inVar1='' then return boolVal
    if inVar2='' then return boolVal
    if inVar2<inVar1 then return 1
    else return 0


/*given a line, see if it passes the adjacent test*/
adjTest: arg curLine
    parse var curLine curLine.1 curLine.2 curLine.3 curLine.4,
    curLine.5 curLine.6 curLine.7 curLine.8 
    valCount=words(curLine)
    outVal=1
    do j=1 to valCount-1 by 1
        k=j+1
        call checkAdj(outVal curLine.j curLine.k)
        outVal = RESULT
    end
    return outVal

    /*given a line, see if it passes the increaing test*/
incTest: arg curLine
    parse var curLine curLine.1 curLine.2 curLine.3 curLine.4,
    curLine.5 curLine.6 curLine.7 curLine.8 
    valCount=words(curLine)
    outVal=1
    do j=1 to valCount-1 by 1
        k=j+1
        call checkIncrease(outVal curLine.j curLine.k)
        outVal = RESULT
    end
    return outVal

/*given a line, see if it passes the decreasing test*/
decTest: arg curLine
    parse var curLine curLine.1 curLine.2 curLine.3 curLine.4,
    curLine.5 curLine.6 curLine.7 curLine.8 
    valCount=words(curLine)
    outVal=1
    do j=1 to valCount-1 by 1
        k=j+1
        call checkDecrease(outVal curLine.j curLine.k)
        outVal = RESULT
    end
    return outVal

/*rebuild a line without an element of a given number*/
rebuildLine: arg num curLine
    parse var curLine curLine.1 curLine.2 curLine.3 curLine.4,
    curLine.5 curLine.6 curLine.7 curLine.8
    outLine=""
    valCount=words(curLine)
    do k=1 to valCount by 1
        if k=num then nop 
        else outLine=outLine curLine.k
    end
    
    return outLine


/*see if you can get a true result for adj by removing 1 variable */
adjDampaner: arg curLine
    parse var curLine curLine.1 curLine.2 curLine.3 curLine.4,
    curLine.5 curLine.6 curLine.7 curLine.8 
    valCount=words(curLine)
    do l=1 to valCount by 1
        call rebuildLine(l curLine)
        workingLine=result
        call adjTest(workingLine)
        safeVal=result
        if safeVal=1 then return 1
    end
    return 0

    /*see if you can get a true result for adj by removing 1 variable */
incDampaner: arg curLine
    parse var curLine curLine.1 curLine.2 curLine.3 curLine.4,
    curLine.5 curLine.6 curLine.7 curLine.8 
    valCount=words(curLine)
    
    do l=1 to valCount by 1
        call rebuildLine(l curLine)
        workingLine=result
        call incTest(workingLine)
        safeVal=result
        if safeVal=1 then return 1
    end
    return 0

    /*see if you can get a true result for adj by removing 1 variable */
decDampaner: arg curLine
    valCount=words(curLine)
     do l=1 to valCount by 1
        call rebuildLine(l curLine)
        workingLine=result
        call decTest(workingLine)
        safeVal=result
        if safeVal=1 then return 1
    end
    return 0

/*test adjacent and decrease under the same conditions of* 
dedAndAdjDampaner: