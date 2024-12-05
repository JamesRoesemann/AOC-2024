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


lastSearchable=inLine.0
lastSearchable=lastSearchable-1


do i=2 to lastSearchable by 1
    j=i-1
    k=i+1
    call findX(inline.j inline.i inline.k)
    totalXmas=totalXmas+result
end

say 'Total X-MAS is:' totalXmas

exit



/*find at least 2 MAS in an X pattern*/
findX: arg string1 string2 string3 
    charPos=2
    foundMas=0
    do while charPos<length(string2)
        charPos=index(string2,'A',charPos+1)
        if charPos<>0 then do
            corner.1=substr(string1,charPos-1,1)
            corner.2=substr(string1,charPos+1,1)
            corner.3=substr(string3,charPos-1,1)
            corner.4=substr(string3,charPos+1,1)

            call isMas(corner.1 corner.3)
            foundMas=foundMas+result
            call isMas(corner.3 corner.1)
            foundMas=foundMas+result
            call isMas(corner.2 corner.4)
            foundMas=foundMas+result
            call isMas(corner.4 corner.2)
            foundMas=foundMas+result
        end
        else charPos=length(string2)
    end
    return foundMas


/*validate if the string passes is a MAS. return 1 if true*/
isMas: arg inChar1 inChar2 
    if inChar1||'A'||inChar2='MAS' then return 1
    else return 0


    /*first ans: 3515. too high*/