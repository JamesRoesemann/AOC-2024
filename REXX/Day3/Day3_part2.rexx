/*REXX*/

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

doOrDontVal=1
totalMulVal=0

/*this will be a loop later*/
do i=1 to inLine.0 by 1
    workingLine=inLine.i /*replace with i*/
    do while length(workingLine)>0


    /*find the next do or don't, if its before the next mul, set doOrDontVal */
        call getDoPos(workingLine)
        doPos=result
        call getDontPos(workingLine)
        dontPos=result
        lowestD=min(doPos,dontPos)
        highestD=max(doPos,dontPos)
        searchD=lowestD
        if searchD=0 then searchD=highestD

        call getMul(workingLine)
        mulVal=RESULT

        /*determin do or don't, set doOrDontVal depending */
        if searchD<>0 & searchD<mulVal then do
            call determineDoOrDont(substr(workingLine,searchD))
            doOrDontVal=result
        end


        workingLine=substr(workingLine,mulVal)
        call getEndMul(workingLine)
        endMulVal=RESULT
        if endMulVal<=9 then do
            /*test the values inbetween*/
            testVal=substr(workingLine,1, endMulVal)
            call getValidMul(testVal)
            validMul=result
            if doOrDontVal=1 then do
                totalMulVal=totalMulVal+validMul
            end
            else nop      
        end
        workingLine=substr(workingLine,2)
    end
end

say "total of uncorrupted mul instructions:" totalMulVal



/*end of program*/
exit


/*find the the begining of the next mul pattern. return the index number*/
getMul: parse arg inVal
    return index(inVal,'mul(')+3

/*find the end of the mul pattern. return the index number*/
getEndMul: parse arg inVal
    return index(inVal,')')


/*given a teststring, see if the available numbers are in the right range*/
/*are in the right format, have no illegal characters are less than 999 */
/*return the left and right side multipled by each other if valid. return 0*/
/*otherwise*/
getValidMul: parse arg inVal
    comaPos=index(inVal,',')
    if comaPos=0 then return 0
    spacePos=index(inval,' ')
    if spacePos>0 then return 0
    leftSide=substr(inval,2,comaPos-2)
    rightSide=substr(inVal,comaPos+1,length(inval)-(comaPos+1)) 
    if datatype(leftSide)<>'NUM' then return 0
    if datatype(rightSide)<>'NUM' then return 0
    call isValidNum(leftSide)
    if result=0 then return 0
    call isValidNum(rightSide)
    if result=0 then return 0
    return leftSide*rightSide



/*test if a number is positive and less that 999. return 1 or 0*/
isValidNum: arg inNum
    if inNum >=0 and inNum<= 999 then return 1
    else return 0 

getDoPos: parse arg inVal
    return index(inVal,'do()')

getDontPos: parse arg inVal
    return index(inVal,"don't()")

determineDoOrDont: parse arg inVal
    if index(inVal,'do()')=1 then return 1
    else return 0




