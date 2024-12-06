/*REXX*/

toggleRules=0

/*read input file*/
inFile='input.txt'
pageNumCount=0
/*open the input file*/
call linein inFile, 1, 0
/* read in the variables. seperate the rues from the input*/
do i=1 while lines(inFile)\==0
    inLine=linein(inFile)
    if inLine="" then toggleRules=1
    if inLine<>"" & toggleRules=0 then do
        rules.i=inLine
        rules.0=i
    end
    else nop
    if inLine<>"" & toggleRules=1 then do
        pageNumCount=pageNumCount+1
        inPages.pageNumCount=inLine
        inPages.0=pageNumCount
    end
    else nop
end
/*close the input file*/
call lineout inFile



sumTargetNums=0
goodLines=0 /*testing var*/
/*itrate through all the number lists*/
do i=1 to inPages.0 by 1
    /*pages presumed to pass untill they fail a rule*/
    passesRules=1
    /*iterate through all the rules untill it fails a rule*/
    do j=1 to rules.0 by 1
        if passesRule<>0 then do
            leftRule=substr(rules.j,1,2)
            rightRule=substr(rules.j,4,2)
            /*test to see if both pages from the rule exist*/
            leftPos=index(inPages.i,leftRule)
            rightPos=index(inPages.i,rightRule)
            if leftPos>0 & rightPos>0 then do
                /* if pages are in the wrong order. fails the rule. end search*/
                if leftPos>rightPos then do
                    passesRules=0
                    j=rules.0
                end
            end
            else nop
        end
    end
    /*extract the middle value to add up*/
    if passesRules=1 then do
        call getMiddleValue(inPages.i)
        sumTargetNums=sumTargetNums+result
        goodLines=goodLines+1

    end
end

say "Total good lines" goodLines
say "Sum of medium values from good lines" sumTargetNums

/*end program*/
exit

getMiddleValue: arg testString
    /*convert , to space to make this a string of words*/
    seperated=translate(testString," ",",")
    intVal=words(seperated)%2
    hasRemainder=words(seperated)//2
    if hasRemainder>0 then do
        midValue=word(seperated,intVal+1)
    end
    else do
        midValue=word(seperated,intVal+1)+word(seperated,intVal)
    end
    return midValue





    /*first ans 10592. too high*/