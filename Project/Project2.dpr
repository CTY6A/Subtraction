Program BbI4UTAHUE;
//program calculates subtraction of two nums
//(up to 50 digits) in any notation

{$APPTYPE CONSOLE}

Uses
  SysUtils;

Var
  NumInStr1,NumInStr2,Alp,Miss1,Miss2: String [50];
//NumInStr1, NumInStr1 - 1st, 2nd Num In Str
//ALp - Alphabet for notation
//Miss1, Miss2 - Misspelling

  NumInArray1,NumInArray2,Sub: Array of Integer;
//NumInArray1, NumInArray2 - Num In Array
//Sub - Subtraction

  i,Notation,Difference,Lgth,OneInTheMind: Integer;
//Notation - Notation
//Difference - Difference
//Lgth - Lgth                                                                          8
//OneInTheMind - One In The Mind

  F1,FMiss1,FMiss2: Boolean;
//F1 - Flag
//FMiss1, FMiss2 - 1st, 2nd FLag for Misspeling

Begin
//input and verification notation for subtraction
  Repeat
    Write ('input Notation (more than 2, less than 36) ');
    Readln (Notation);

(*if Notation is not within a 'reasonable framework' - output error and repeat*)
    If (Notation < 2) or (Notation > 36) then
      Writeln ('incorrect input data. try now ')
  Until (Notation>1) and (Notation<37);

//creation of Alphabet for chosen Notation
  For i := 1 to Notation do
    If i <= 10 then
      Alp :=Alp + Char(47 + i)
    Else
      Alp := Alp + Char(54 + i);

//input nums for Subtraction
  Write ('input 1st num ');
  Readln (NumInStr1);
  Write ('input 2nd num ');
  Readln(NumInStr2);

//initializing cycle
  FMiss1 := False;
  FMiss2 := False;

//cycles for searching, deleting from strings
//and storing unnecessary characters:
(*initializing*)
  i:=1;
  While i <= Length(NumInStr1) do
  Begin
(*removing zeros*)
    While (NumInStr1[1] = '0') and (Length(NumInStr1) >= 1) do
      Delete (NumInStr1,1,1);

(*if character isn't in Alp - delete and storing it in Mis-spelling*)
    If Pos(NumInStr1[i],Alp) = 0 then
    Begin
      Miss1 := Miss1 + NumInStr1[i] + ' ';
      Delete (NumInStr1,i,1);

(*if there is at least one misspelling - error is display*)
      FMiss1 := True;
    End
    Else
      i := i + 1
  End;
(*initializing*)
  i := 1;
  While i <= Length(NumInStr2) do
  Begin

(*removing zeros*)
    While (NumInStr2[1] = '0') and (Length(NumInStr2) >= 1) do
      Delete (NumInStr2,1,1);

(*if character isn't in Alp - delete and storing it in Mis-spelling*)
    If Pos(NumInStr2[i],Alp) = 0  then
    Begin
      Miss2 := Miss2 + NumInStr2[i] + ' ';
      Delete (NumInStr2,i,1);

(*if there is at least one misspelling - error is display*)
      FMiss2 := true
    End
    Else
      i := i + 1
  End;

//finding larger str
  If (Length(NumInStr1) = Length(NumInStr2)) and 
  (NumInStr1 >= NumInStr2) or
  (Length(NumInStr1) > Length(NumInStr2)) then
    F1 := true
  Else 
    F1 := false;

//finding difference between str
  Difference := Abs(Length(NumInStr1) - Length(NumInStr2));

//length setting
  If F1 then
    Lgth := Length(NumInStr1) - 1
  Else 
    Lgth := Length(NumInStr2) - 1;

//line alignment by number of characters
  For i := 1 to Difference do
    If F1 then
      Insert ('0',NumInStr2,1)
    Else 
      Insert('0',NumInStr1,1);

//introduction of dynamic arrays for Num
  SetLength(NumInArray1,Lgth + 1);
  SetLength(NumInArray2,Lgth + 1);

//cycle for translating each line element to the number of //its position in the alphabet created earlier for 
//arithmetic operations:
  For i := 0 to Lgth do
  Begin
    NumInArray1[i] := Pos(NumInStr1[i + 1],Alp) - 1;
    NumInArray2[i] := Pos(NumInStr2[i + 1],Alp) - 1
  End;

//create dynamic array for the sum and initialize cycle:
  SetLength(Sub,Lgth + 1);
  OneInTheMind := 0;

//cycle for subtraction:
  For i := Lgth downto 0 do
  Begin

(*if 1st num larger - subtract from it, else - from 2nd num*)
    If F1 then
      Sub[i] := NumInArray1[i]-NumInArray2[i]- OneInTheMind
    Else
      Sub[i] := NumInArray2[i]-NumInArray1[i]-OneInTheMind;

(*if Subtract less than zero - add the base of notation*)
    If Sub[i] < 0 then
    Begin
      Sub[i] := Sub[i] + Notation;
      OneInTheMind := 1
    End
    Else 
      OneInTheMind := 0;
  End;

//elimination of an insignificant zero
  While (Sub[0] = 0) and (Length(Sub) >  1) do
  Begin
    For i := 0 to Lgth do
      Sub[i] := Sub[i+1];
    Lgth := Lgth - 1 ;
  End;

//data output
  Write ('Sub: ');

//if 1st num less than 2nd - write '-'
  If not F1 then
    Write ('-');
  For i := 0 to Lgth do
    Write (Alp[Sub[i]+1]);
  Writeln;

//output unnecessary characters
  If FMiss1 then
    Writeln('misspelling in 1st num: ', Miss1);
  If FMiss2 then
    Writeln('misspelling in 2nd num: ', Miss2);
  Readln
End.

