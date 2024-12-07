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

/*sort to make fixing the broken page lines easier later*/
ADDRESS SYSTEM "sort" WITH INPUT STEM rules. OUTPUT STEM rules.

badlines=0
sumTargetNums=0
goodLines=0 /*testing var*/
/*itrate through all the number lists*/
do i=1 to inPages.0 by 1
    /*pages presumed to pass untill they fail a rule*/
    passesRules=1

    /*iterate through all the rules untill it fails a rule*/
    do j=1 to rules.0 by 1
        if passesRule<>0 then do
            call isValid(rules.j inPages.i)
            if result=0 then do
                passesRules=0
                j=rules.0
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
    else do
        badLines=badLines+1
        brokenUpdates.badLines=inPages.i
        brokenUpdates.0=badLines
    end
end




say "Total good lines" goodLines
say "Sum of medium values from good lines" sumTargetNums





/*now do the broken values*/
sumBrokenlines=0
do i=1 to brokenUpdates.0 by 1

    fixedUpdate=0
    do while fixedUpdate<>1
        passesRules=1
        do j=1 to rules.0 by 1
            leftRule=substr(rules.j,1,2)
            rightRule=substr(rules.j,4,2)
            leftPos=index(brokenUpdates.i,leftRule)
            rightPos=index(brokenUpdates.i,rightRule)

            call isValid(rules.j brokenUpdates.i)
            testResult=result
            if testResult=0 then do

                passesRules=0
                call reOrder(rule.j brokenUpdates.i)
                brokenUpdates.i=result

            end 
            else nop
        end
        if passesRules=1 then do
            fixedUpdate=1 
        end
    end
    call getMiddleValue(brokenUpdates.i)
    sumBrokenlines=sumBrokenlines+result

end

say "The sum from the Broken Updates is:" sumBrokenlines


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





/*given a string of words and two numbers in that string, reorder the words*/
/*so that the first number must be before the second*/


reOrder: arg inRule. inString

    target1=substr(inRule,1,2) 
    target2=substr(inRule,4,2)
    outString=""
    inString=translate(inString," ",',')
    wordCount=words(inString)
    pos1=wordpos(target1,inString)
    pos2=wordpos(target2,inString)
    if pos1=0 | pos2=0 then return inString
    if pos1>pos2 then do

        outString=target1" "subword(inString,1,pos2-1)
        /*get the numbers between the 2 targets, if any*/
        midPortion=subWord(instring,pos2+1,pos1-pos2-1)
        /*after the moving target*/
        backHalf=subword(instring,pos1+1,words(inString))
        /*rebuild string*/
        outString=outString" "target2" "midPortion" "backHalf
    end
    else outString=inString
    return outString


/*given a string and a list of rules, returnes true if it passes all rules*/
/* and false otherwise*/
isValid: arg inRule inString
    leftRule=substr(inRule,1,2)
    rightRule=substr(inRule,4,2)
    leftPos=index(inString,leftRule)
    rightPos=index(inString,rightRule)

    if leftPos=0 | rightPos=0 then return 1
    if leftPos>0 & rightPos>0 & leftPos>rightPos then do
        RETURN 0
    END
    else return 1








/*first ans. 6190. too low*/