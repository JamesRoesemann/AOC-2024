/*REXX*/

/*count all instances of xmas in this file.*/ 
/*foweards, backwards,horizontoly, verticly, diagnoally,*/
/* even overlapping with other words.*/

/*the left and right version of this is easy,*/
/*just count each each foward/backward substring in each line and add */
/*to the total */

/*6 other functions would be needed to determine the others*/
/*starting from an x, searcheither north, south, north west, northeast,*/
/*south west or south east for the xmas pattern*/

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

totalXmas=0

do i=1 to inLine.0 by 1

    
    
    call findHoriz(inLine.i 'XMAS')
    totalXmas=totalXmas+result
    call findHoriz(inLine.i 'SAMX')
    totalXmas=totalXmas+result
    /*verticle and diag search.*/
    if (i<=inLine.0)then do
        j=i+1
        k=i+2
        l=i+3
        call getVertValue(inLine.i inLine.j inLine.k inLine.l 'XMAS')
        totalXmas=totalXmas+result
        call getVertValue(inLine.i inLine.j inLine.k inLine.l 'SAMX')
        totalXmas=totalXmas+result
        call getRightDiagValue(inLine.i inLine.j inLine.k inLine.l 'XMAS')
        totalXmas=totalXmas+result
        call getRightDiagValue(inLine.i inLine.j inLine.k inLine.l 'SAMX')
        totalXmas=totalXmas+result
        call getLeftDiagValue(inLine.i inLine.j inLine.k inLine.l 'XMAS')
        totalXmas=totalXmas+result
        call getLeftDiagValue(inLine.i inLine.j inLine.k inLine.l 'SAMX')
        totalXmas=totalXmas+result   
    end
end


/*final answer*/
say "Total number of XMAS in word search:" totalXmas 








/*end program*/
exit









/*find all XMAS in a line. return a number, add to total*/
findHoriz: arg workingLine searchString
    nextPos=0
    xmasOut=0
    do while nextPos<length(workingLine)
        nextPos=index(workingLine,searchString,nextPos+1)
        if nextPos=0 then nextPos=length(workingLine)
        else xmasOut=xmasOut+1
    end
    return xmasOut


/*given 4 strings to search, return all verticle values of the target string,*/
/*using the first string as a starting point*/
getVertValue: arg inString1 inString2 inString3 instring4 searchString
    char1=substr(searchString,1,1)
    char2=substr(searchString,2,1)
    char3=substr(searchString,3,1)
    char4=substr(searchString,4,1)
    outVal=0
    charPos=0
    do while charPos<length(inString1)
        /*find starting character*/
        charPos=index(inString1,char1,charPos+1)
        if charPos=0 then charPos=length(inString1)
        /*the actual search*/
        else do
            if substr(inString2,charPos,1)=char2 &,
            substr(inString3,charPos,1)=char3 &,
            substr(inString4,charPos,1)=char4 then do
                outVal=outVal+1
            end
        end
    end
    return outVal


/*given 4 strings to search, return all dignal values of the target string,*/
/* sloping dowrightwards, using the first string as a starting point*/
getRightDiagValue: arg inString1 inString2 inString3 instring4 searchString
    char1=substr(searchString,1,1)
    char2=substr(searchString,2,1)
    char3=substr(searchString,3,1)
    char4=substr(searchString,4,1)
    outVal=0
    charPos=0
    do while charPos<length(inString1)
        /*find starting character*/
        charPos=index(inString1,char1,charPos+1)
        if charPos=0 then charPos=length(inString1)
        /*the actual search*/
        else do
            if substr(inString2,charPos+1,1)=char2 &,
            substr(inString3,charPos+2,1)=char3 &,
            substr(inString4,charPos+3,1)=char4 then do
                outVal=outVal+1
            end
        end
    end
    return outVal


/*given 4 strings to search, return all diagnal values of the target string,*/
/* sloping leftwards, using the first string as a starting point*/
getLeftDiagValue: arg inString1 inString2 inString3 instring4 searchString
    char1=substr(searchString,1,1)
    char2=substr(searchString,2,1)
    char3=substr(searchString,3,1)
    char4=substr(searchString,4,1)
    outVal=0
    charPos=3
    do while charPos<length(inString1)
        /*find starting character*/
        charPos=index(inString1,char1,charPos+1)
        if charPos=0 then charPos=length(inString1)
        /*the actual search*/
        else do
            if substr(inString2,charPos-1,1)=char2 &,
            substr(inString3,charPos-2,1)=char3 &,
            substr(inString4,charPos-3,1)=char4 then do
                outVal=outVal+1
            end
        end
    end
    return outVal

