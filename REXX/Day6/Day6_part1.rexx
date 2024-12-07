/*rexx*/


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



/*find the starting position*/
do i=0 to inLine.0 by 1
    if index(inLine.i,'^')>0 then do
        xAxis=index(inLine.i,'^')
        yAxis=i
        i=inLine.0
    end
end


countSteps=1

/*the boundries are 0 and 130 */
outOfBounds=0
do while xAxis>0 & xAxis<=130 & yAxis>0 & yAxis<=130 & outOfBounds=0

    call testCordinates(xAxis yAxis outOfBounds)
    if result=1 then do
    /*go north*/
    hitObstacle=0

    do while yAxis>0 & xAxis<131 & hitObstacle=0 & outOfBounds=0
        if substr(inLine.yAxis,xAxis,1)<>'#' then do
            call replaceChar(inLine.yAxis xAxis)
            inLine.yAxis=result
            countSteps=countSteps+1
            yAxis=yAxis-1
            
        end
        else do
            hitObstacle=1
            xAxis=xAxis+1
            yAxis=yAxis+1
            call replaceChar(inLine.yAxis xAxis)
            inLine.yAxis=result
            countSteps=countSteps+1
        end
        if yAxis=0 then outOfBounds=1
    end
    end

    call testCordinates(xAxis yAxis outOfBounds)
    if result=1 then do
    /*go East*/
    hitObstacle=0
    do while xAxis<131 & yAxis<131 & hitObstacle=0 & outOfBounds=0
        if substr(inLine.yAxis,xAxis,1)<>'#' then do
            call replaceChar(inLine.yAxis xAxis)
            inLine.yAxis=result
            countSteps=countSteps+1
            xAxis=xAxis+1
        end
        else do
            hitObstacle=1
            yAxis=yAxis+1
            xAxis=xAxis-1
            call replaceChar(inLine.yAxis xAxis)
            inLine.yAxis=result
            countSteps=countSteps+1
        end
        if xAxis>130 then outOfBounds=1
    end
    end

    call testCordinates(xAxis yAxis outOfBounds)
    if result=1 then do

    /*go South*/
    hitObstacle=0
    do while yAxis<131 & xAxis>0 & hitObstacle=0 & outOfBounds=0
        if substr(inLine.yAxis,xAxis,1)<>'#' then do
            call replaceChar(inLine.yAxis xAxis)
            inLine.yAxis=result
            countSteps=countSteps+1
            yAxis=yAxis+1
        end
        else do
            hitObstacle=1
            xAxis=xAxis-1
            yAxis=yAxis-1
            call replaceChar(inLine.yAxis xAxis)
            inLine.yAxis=result
            countSteps=countSteps+1
        end

        if yAxis>130 then outOfBounds=1
    end
    end

    call testCordinates(xAxis yAxis outOfBounds)
    if result=1 then do


    /*go west*/
    hitObstacle=0

    do while xAxis>0 & yAxis>0 & hitObstacle=0 & outOfBounds=0
        if substr(inLine.yAxis,xAxis,1)<>'#' then do
            call replaceChar(inLine.yAxis xAxis)
            inLine.yAxis=result
            countSteps=countSteps+1
            xAxis=xAxis-1
        end
        else do
            hitObstacle=1
            yAxis=yAxis-1
            xAxis=xAxis+1
            call replaceChar(inLine.yAxis xAxis)
            inLine.yAxis=result
            countSteps=countSteps+1
        end

        if xAxis=0 then outOfBounds=1
    end
    end


end

say countSteps "STEPS"


uniqueLocations=0
do i=1 to inLine.0 by 1
    testString=strip(inLine.i)
    call countLoc(testString)
    uniqueLocations=uniqueLocations+result
end

say uniqueLocations UNIQUE LOCATIONS


exit


/*returns 1 if all conditions are still valid. 0 otherwise*/
testCordinates: arg x y OOB
if x>0 & x<131 & y>0 & y<131 & OOb=0 then return 1
else return 0


/*replace the character in line with an X. this will be used for counting*/
/*unique locations*/
replaceChar: arg inString x
    front=substr(instring,1,x-1)
    back=substr(instring,x+1,length(inString)-1)
    return front||"X"||back


countLoc: arg inString
    total=0
    do j=1 to length(inString) by 1
        if substr(inString,j,1)="X" then do
            total=total+1
        end
    end
    return total


/*first answer. 412*/
/*second andwer. 413. still too low*/
/*third 4961. too high*/
/*4824. not right*/
/*4960. still not right*/
/*4433*/
