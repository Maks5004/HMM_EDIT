IMPLEMENTATION MODULE M_Main;

 IMPORT IO,Str;
 FROM Window  IMPORT AbsCoord,CursorOn,CursorOff,FrameStr,DirectWrite,ClrEol,DelLine,Hide,
                     RelCoord,ConvertCoords,GotoXY,At,SetTitle,TitleMode,
                     Use,Open,WinDef,WinType,Color,InsLine,Clear,SingleFrame,
                     TextColor,DoubleFrame,Close,PutOnTop,Change;

 VAR  WD         : ARRAY[1..256] OF WinDef;
      WT         : ARRAY[1..256] OF WinType;
      C          : CHAR;
      X,Y        : CARDINAL;

 PROCEDURE OpenBck(D:CHAR;F,B:CARDINAL);
 VAR X,Y:CARDINAL;
 BEGIN
  BD.FrameOn:=FALSE;
  BD.WrapOn:=TRUE;
  BD.Hidden:=FALSE;
  BD.Foreground:=Color(F);
  BD.Background:=Color(B);
  BD.X1:=0;
  BD.X2:=80;
  BD.Y1:=0;
  BD.Y2:=25;
  BT:=Open(BD);
  FOR X:=1 TO 80 DO
   FOR Y:=1 TO 24 DO
    GotoXY(X,Y);IO.WrStr(D);
   END;
  END;
  SHAD.FrameOn:=FALSE;;
  SHAD.WrapOn:=TRUE;
  SHAD.Hidden:=FALSE;
  SHAD.Foreground:=Color(1);
  SHAD.Background:=Color(7);
  SHAD.X1:=0;
  SHAD.X2:=80;
  SHAD.Y1:=24;
  SHAD.Y2:=25;
  SHAT:=Open(SHAD);
 END OpenBck;

 PROCEDURE CloseBck;
 BEGIN
  Close(BT);
  Close(SHAT);
 END CloseBck;

 PROCEDURE SetStyle(Nom:CARDINAL;Nb,Fr:SHORTCARD);
 BEGIN

  WD[Nom].WrapOn:=TRUE;
  WD[Nom].Hidden:=FALSE;
  WD[Nom].FrameOn:=TRUE;

  SHD.FrameOn:=FALSE;
  SHD.WrapOn:=TRUE;
  SHD.Hidden:=FALSE;

  CASE Fr OF
   | 1 : WD[Nom].FrameDef:="╔═╗║║╚═╝";
   | 2 : WD[Nom].FrameDef:="┌─┐││└─┘";
   | 3 : WD[Nom].FrameDef:="╓─╖║║╙─╜";
   | 4 : WD[Nom].FrameDef:="╒═╕││╘═╛";
   | 5 : WD[Nom].FrameDef:="▐▀▌▐▌▐▄▌";
  END;
  CASE Nb OF
   | 1 : WD[Nom].Foreground:=Color(15);
         WD[Nom].Background:=Color(1);
         WD[Nom].CursorOn:=FALSE;

         WD[Nom].FrameFore:=Color(7);
         WD[Nom].FrameBack:=Color(1);

         SHD.Foreground:=Color(0);
         SHD.Background:=Color(7);

  END;
 END SetStyle;


 PROCEDURE Open_Menu(Nom,X0,Y0:CARDINAL;DEST:Menu):CARDINAL;
 VAR R,S:CARDINAL;
     I,I1:CARDINAL;

  PROCEDURE MAX():CARDINAL;
  BEGIN;
   R:=Str.Length(DEST.A_Nm[1].Mn);
   I:=1;
   WHILE Str.Length(DEST.A_Nm[I].Mn)#0 DO
    IF R<Str.Length(DEST.A_Nm[I].Mn) THEN R:=Str.Length(DEST.A_Nm[I].Mn);END;
    INC(I);
   END;
   RETURN R;
  END MAX;

  PROCEDURE SUM():CARDINAL;
  BEGIN
   S:=Str.Length(DEST.A_Nm[1].Mn);
   I:=1;
   WHILE Str.Length(DEST.A_Nm[I].Mn)#0 DO
    S:=S+Str.Length(DEST.A_Nm[I].Mn);
    INC(I);
   END;
   RETURN S;
  END SUM;

 BEGIN
  IF SHT#NIL THEN Close(SHT) END;
  WD[Nom].X1:=X0;
  WD[Nom].Y1:=Y0;
  SHD.X1:=X0+1;
  SHD.Y1:=Y0+1;
  X:=X0+1;
  IF DEST.UD=TRUE THEN
   I1:=SUM();
   WD[Nom].X2:=X0+(I-1)*10;
   WD[Nom].Y2:=Y0;
   SHD.X2:=X0+Str.Length(DEST.A_Nm[1].Mn)+1;
   SHD.X1:=X0;
   SHD.Y1:=Y0;
   SHD.Y2:=Y0;

   WD[Nom].FrameOn:=FALSE;
   WT[Nom]:=Open(WD[Nom]);
   I1:=I;
   FOR I:=1 TO I1 DO
    GotoXY((I-1)*10+2,0);
    IO.WrStr(DEST.A_Nm[I].Mn);
   END;
   Y:=1;
   X:=1;I1:=1;
   IF SHT=NIL THEN SHT:=Open(SHD); ELSE
    Change(SHT,X0+(I1-1)*10,Y0,X0+(I1-1)*10+Str.Length(DEST.A_Nm[I1].Mn)+2,Y0);
   END;
   Clear;
   IO.WrStr(" ");
   IO.WrStr(DEST.A_Nm[1].Mn);
   Use(SHAT);
   Clear;
   IO.WrStr(DEST.A_Nm[1].Cm);
   Use(SHT);
   LOOP
    C:=IO.RdKey();
    CASE ORD(C) OF
     |27:
          RETURN(0);
          EXIT;
     |13:
          RETURN(I1);
          EXIT;

     |0: C:=IO.RdKey();
         (*IO.WrCard(ORD(C),1);*)
         CASE ORD(C) OF
          |80,77:IF I1<I-1 THEN
               I1:=I1+1;
              ELSE
               I1:=1
              END;
              Change(SHT,X0+(I1-1)*10,Y0,X0+(I1-1)*10+Str.Length(DEST.A_Nm[I1].Mn)+2,Y0);
              Clear;
              IO.WrStr(" ");
              IO.WrStr(DEST.A_Nm[I1].Mn);
              Use(SHAT);
              Clear;
              IO.WrStr(DEST.A_Nm[I1].Cm);
              Use(SHT);
          |72,75:IF I1>1 THEN
               I1:=I1-1;
              ELSE
               I1:=I-1;
              END;
              Change(SHT,X0+(I1-1)*10,Y0,X0+(I1-1)*10+Str.Length(DEST.A_Nm[I1].Mn)+2,Y0);
              Clear;
              IO.WrStr(" ");
              IO.WrStr(DEST.A_Nm[I1].Mn);
              Use(SHAT);
              Clear;
              IO.WrStr(DEST.A_Nm[I1].Cm);
              Use(SHT);

         END;
    END;
   END;
  ELSE
   WD[Nom].X2:=X0+MAX()+2;
   WD[Nom].Y2:=Y0+I;

   SHD.X2:=X0+MAX()+1;
   SHD.Y2:=Y0+1;
   SD.X1:=WD[Nom].X1+1;
   SD.Y1:=WD[Nom].Y1+1;
   SD.X2:=WD[Nom].X2+1;
   SD.Y2:=WD[Nom].Y2+1;
   ST:=Open(SD);
   WT[Nom]:=Open(WD[Nom]);
   I1:=I;
   FOR I:=1 TO I1 DO
    IO.WrStr(DEST.A_Nm[I].Mn);
    IF I<I1-1 THEN IO.WrLn; END;
   END;

   Y:=1;
   SHT:=Open(SHD);
   IO.WrStr(DEST.A_Nm[Y].Mn);
   Use(SHAT);
   Clear;
   IO.WrStr(DEST.A_Nm[Y].Cm);
   Use(SHT);

   LOOP
    C:=IO.RdKey();
    CASE ORD(C) OF
     |27:
          RETURN(0);
          EXIT;
     |13:
          RETURN(Y);
          EXIT;

     |0: C:=IO.RdKey();
         (*IO.WrCard(ORD(C),1);*)
         CASE ORD(C) OF
          |80,77:IF Y<I-1 THEN
               Y:=Y+1;
              ELSE
               Y:=1;
              END;
              Change(SHT,X,Y+Y0,X+MAX(),Y+Y0);
              Clear;
              IO.WrStr(DEST.A_Nm[Y].Mn);
              Use(SHAT);
              Clear;
              IO.WrStr(DEST.A_Nm[Y].Cm);
              Use(SHT);
          |72,75:IF Y>1 THEN
               Y:=Y-1;
              ELSE
               Y:=I-1;
              END;
              Change(SHT,X,Y+Y0,X+MAX(),Y+Y0);
              Clear;
              IO.WrStr(DEST.A_Nm[Y].Mn);
              Use(SHAT);
              Clear;
              IO.WrStr(DEST.A_Nm[Y].Cm);
              Use(SHT);
         END;
    END;
   END;
  END;
 END Open_Menu;

 PROCEDURE Close_Menu(NOM:CARDINAL);
 BEGIN
  Close(WT[NOM]);
  IF SHT#NIL THEN Close(SHT); END;
  IF ST#NIL THEN Close(ST); END;
 END Close_Menu;

END M_Main.
