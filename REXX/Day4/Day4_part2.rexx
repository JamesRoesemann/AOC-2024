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


totalXmas=0
maxLines=inLine.0



do i=1 to maxLines by 1
    j=i-1
    k=i+1
    call findX(inline.j inline.i inline.k)
    totalXmas=totalXmas+result
end



say 'Total X-MAS is:' totalXmas

exit



/*find at least 2 MAS in an X pattern*/
findX: arg string1 string2 string3 
    charPos=1
    foundMas=0
    do while charPos<=length(string2)
        masTest=0
        charPos=index(string2,'A',charPos+1)
        if charPos<>0 then do
            corner.1=substr(string1,charPos-1,1) /*NW*/
            corner.2=substr(string1,charPos+1,1) /*NE*/
            corner.3=substr(string3,charPos-1,1) /*SW*/
            corner.4=substr(string3,charPos+1,1) /*SE*/
            
            call isMas(corner.1 corner.4) 
            masTest=masTest+result
            call isMas(corner.4 corner.1) 
            masTest=masTest+result
            call isMas(corner.2 corner.3) 
            masTest=masTest+result
            call isMas(corner.3 corner.2) 
            masTest=masTest+result
            if masTest=>2 then do
                foundMas=foundMas+1
            end
            
            /*call checkMasRightSide(corner.1 corner.2 corner.3 corner.4)
            masTest=result
            if masTest=2 then foundMas=foundMas+1*/

        end
        else charPos=length(string2)+1
    end

    return foundMas


/*validate if the string passes is a MAS. return 1 if true*/
isMas: arg inChar1 inChar2 
    if inChar1||'A'||inChar2='MAS' then return 1
    else return 0

checkMasRightSide: arg nw ne sw se
    /* NW NE SW SE*/
    if (nw ='M' & ne = 'M') & ( sw='S' & se='S') then return 2 /*north south*/
    if (nw ='M' & sw = 'M') & ( ne='S' & ne='S') then return 2 /*west east*/
    if (sw ='M' & se = 'M') & ( nw='S' & ne='S') then return 2 /*south North*/
    if (ne ='M' & se = 'M') & ( sw='S' & nw='S') then return 2 /*east West*/
    return 0

    /*first ans: 3515. too high*/
    /*second and: 1810 too low*/
    /*third ans: 1944 too low*/
    /*forth 1972: not right answer. but right for someone else*/
    /*2258 not right*/