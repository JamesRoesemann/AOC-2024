/* REXX */
/* Solution for Advent of code 2024 Day 1*/
/* Given a file with two columns of numbers, sort the columns.*/
/* Get the diffrence of each sorted pair, smallest to largest.*/
/* The Sum of all the diffrences for a total difrence is the solution.*/



inFile='input.txt'
totalDif=0
totalSim=0

/*open the input file*/
call linein inFile, 1, 0


/* read in the variables*/
do i=1 while lines(inFile)\==0
    currentLine=linein(inFile)
    parse VAR currentLine leftSide.i rightSide.i
    leftSide.i=strip(leftSide.i)
    rightSide.i=strip(rightSide.i)
    leftSide.0=i
    rightSide.0=i
end


/*close the input file*/
call lineout inFile

/*sort*/
ADDRESS SYSTEM "sort" WITH INPUT STEM leftSide. OUTPUT STEM leftSide.
ADDRESS SYSTEM "sort" WITH INPUT STEM rightSide. OUTPUT STEM rightSide.


/*set smallest value to the left, largest to the right */
/*then add diffrence to total*/
do i=0 to leftSide.0 by 1
    tempMax=max(leftSide.i,rightSide.i)
    tempMin=min(leftSide.i,rightSide.i)
    totalDif=totalDif+(tempMax-tempMin)
end

say "Total diffrence: " totalDif


/*part 2: see how many times a number in the first list occurs */
/* in the Second list*/

do i=0 to leftSide.0 by 1
/* set a baseline Sim Score of 0*/
    leftSide.i.simScore=0
    /*search the second list. if a match occurs, increase simScore*/ 
    do j=0 to rightSide.0 by 1
        if leftSide.i=rightSide.j then 
        do
            leftSide.i.simScore=leftSide.i.simScore+1
        end
        else nop
    end
end

/*get the total sim values*/
do i=1 to leftSide.0 by 1
    currentSimVal=leftSide.i.simScore*leftSide.i
    totalSim=totalSim+currentSimVal
end 

say "Total similarity score: " totalSim

exit