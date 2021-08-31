MODULE HMM_EDIT;

 IMPORT FIO,IO,Str,M_Main;
 FROM   Lib      IMPORT CommandType,Environment,ParamStr,ParamCount,Delay;
 FROM Window  IMPORT WinType,WinDef,Open,SetTitle,SetFrame,Use,DoubleFrame,
                     PutOnTop,PutBeneath,Hide,Change,Close,AbsCoord,PutOnTop,
                     GotoXY,Clear,CursorOn,CursorOff,Color,TextColor;

 TYPE Hero=RECORD
       Name1 : ARRAY[0..16] OF CHAR;
       Name2 : ARRAY[0..8] OF CHAR;
       DNN1  : ARRAY[0..19] OF BYTE;
       B_A   : SHORTCARD;
       B_D   : SHORTCARD;
       B_M   : SHORTCARD;
       B_K   : SHORTCARD;
       DNN2  : ARRAY[0..34] OF BYTE;
       A_1   : SHORTCARD;
       A_2   : SHORTCARD;
       A_3   : SHORTCARD;
       A_4   : SHORTCARD;
       A_5   : SHORTCARD;
       CA_1  : CARDINAL;
       CA_2  : CARDINAL;
       CA_3  : CARDINAL;
       CA_4  : CARDINAL;
       CA_5  : CARDINAL;
       DNN3  : ARRAY[0..81] OF BYTE;
      END;

VAR PrStr,GRT : ARRAY[1..15] OF CHAR;
    REC       : ARRAY[1..36] OF Hero;
    F,D       : CARDINAL;
    E         : CHAR;
    WT        : ARRAY[0..5] OF WinType;
    WD        : ARRAY[0..5] OF WinDef;

 PROCEDURE FindHero(N:ARRAY OF CHAR):CARDINAL;
 VAR S : CARDINAL;
     L : CARDINAL;
     C : CHAR;

  PROCEDURE Prov(S:CARDINAL):BOOLEAN;
   VAR B : BOOLEAN;
       V : CARDINAL;
  BEGIN
   B:=TRUE;
   FOR V:=1 TO L DO
    IF REC[S].Name1[V]#N[V-1] THEN B:=FALSE; END;
   END;
   RETURN B;
  END Prov;

 BEGIN
  L:=Str.Length(N);
  S:=1;
   WHILE (Prov(S)#TRUE) AND (S<36) DO
    S:=S+1;
   END;
  RETURN S
 END FindHero;


  PROCEDURE WINDOW(X0,Y0,X1,Y1:AbsCoord;N:CARDINAL);
  BEGIN
   WD[N].X1:=X0;WD[N].Y1:=Y0;WD[N].X2:=X1;WD[N].Y2:=Y1;
   WD[N].Foreground:=Color(15);
   WD[N].Background:=Color(1);WD[N].CursorOn:=FALSE;WD[N].WrapOn:=TRUE;
   WD[N].Hidden:=FALSE;WD[N].FrameOn:=TRUE;WD[N].FrameDef:=DoubleFrame;
   WD[N].FrameFore:=Color(7);WD[N].FrameBack:=Color(1);
   WT[N]:=Open(WD[N]);
  END WINDOW;

  PROCEDURE Serch():CARDINAL;
   VAR  N,Y,S   : CARDINAL;
        SHD     : WinDef;
        SHT     : WinType;
        C       : CHAR;
        ST      : ARRAY[1..40] OF CHAR;

   PROCEDURE WRITE(A:CARDINAL);
    VAR D:CARDINAL;
   BEGIN
    Use(WT[1]);
    Clear;
    FOR D:=0 TO 21 DO
     TextColor(Color(15));
     IO.WrStr(REC[D+A].Name1);
     IF D<21 THEN IO.WrLn;END;
    END;
   END WRITE;

   PROCEDURE EDIT(N:CARDINAL);
   VAR Mn1:ARRAY[1..5] OF ARRAY[0..10] OF CHAR;
       Mn2:ARRAY[1..28] OF ARRAY[0..10] OF CHAR;
       Y1,Y2,N1:CARDINAL;
       B:BOOLEAN;

      PROCEDURE WRITE(A:CARDINAL);
       VAR D:CARDINAL;
      BEGIN
       Use(WT[3]);
       Clear;
       FOR D:=0 TO 21 DO
        TextColor(Color(7));
         CASE A+D OF
          |1..6:TextColor(Color(2));
          |7..12:TextColor(Color(3));
          |13..18:TextColor(Color(10));
          |19..24:TextColor(Color(7));
          |25..28:TextColor(Color(5));
         END;
        IO.WrStr(Mn2[D+A]);
        IF D<21 THEN IO.WrLn;END;
       END;
      END WRITE;

   BEGIN
    Mn1[1]:="Army 1";
    Mn1[2]:="Army 2";
    Mn1[3]:="Army 3";
    Mn1[4]:="Army 4";
    Mn1[5]:="Army 5";
    Mn2[1]:="Peasant";
    Mn2[2]:="Archer";
    Mn2[3]:="Pikeman";
    Mn2[4]:="Swordsman";
    Mn2[5]:="Cavalry";
    Mn2[6]:="Paladin";
    Mn2[7]:="Goblin";
    Mn2[8]:="Orc";
    Mn2[9]:="Wolf";
    Mn2[10]:="Ogre";
    Mn2[11]:="Troll";
    Mn2[12]:="Cyclops";
    Mn2[13]:="Sprite";
    Mn2[14]:="Dwadf";
    Mn2[15]:="Elf";
    Mn2[16]:="Druid";
    Mn2[17]:="Unicorn";
    Mn2[18]:="Phoenix";
    Mn2[19]:="Centaur";
    Mn2[20]:="Gardoyle";
    Mn2[21]:="Griffin";
    Mn2[22]:="Minotaur";
    Mn2[23]:="Hydra";
    Mn2[24]:="Dragon";
    Mn2[25]:="Rogue";
    Mn2[26]:="Nomad";
    Mn2[27]:="Ghost";
    Mn2[28]:="Gemie";
    WINDOW(19,0,27,6,2);
    IO.WrStr(Mn1[1]);
    FOR Y1:=2 TO 5 DO
     IO.WrLn;
     IO.WrStr(Mn1[Y1]);
    END;
    Use(SHT);
    Change(SHT,20,1,26,1);
    PutOnTop(SHT);
    Clear;
    IO.WrStr(Mn1[1]);
    Y1:=1;
    LOOP
    C:=IO.RdKey();
    CASE ORD(C) OF
     |13: B:=FALSE;
          WINDOW(28,0,42,23,3);
          WRITE(1);
          PutOnTop(SHT);
          Change(SHT,29,1,41,1);
          Use(SHT);
          Clear;
          IO.WrStr(Mn2[1]);
          Y2:=1;N1:=1;
          LOOP
           IF B=TRUE THEN
            Use(SHT);
            Change(SHT,20,Y1,26,Y1);
            Clear;
            IO.WrStr(Mn1[Y1]);EXIT;
           END;
           C:=IO.RdKey();
           CASE ORD(C) OF
            |13:WINDOW(43,Y2-1,70,Y2-1,4);
                IO.WrStr("Количество воинов:");
                CASE Y1 OF
                 |1:REC[N].CA_1:=IO.RdCard();
                    REC[N].A_1:=SHORTCARD(N1-1);
                 |2:REC[N].CA_2:=IO.RdCard();
                    REC[N].A_2:=SHORTCARD(N1-1);
                 |3:REC[N].CA_3:=IO.RdCard();
                    REC[N].A_3:=SHORTCARD(N1-1);
                 |4:REC[N].CA_4:=IO.RdCard();
                    REC[N].A_4:=SHORTCARD(N1-1);
                 |5:REC[N].CA_5:=IO.RdCard();
                    REC[N].A_5:=SHORTCARD(N1-1);
                END;
                REC[N].B_A:=15;
                REC[N].B_D:=15;
                REC[N].B_M:=15;
                REC[N].B_K:=15;
                Close(WT[4]);B:=TRUE;
            |27:Use(SHT);
                Change(SHT,20,Y1,26,Y1);
                Clear;
                IO.WrStr(Mn1[Y1]);
                EXIT;
            |80,77:IF N1<28 THEN
                    INC(N1);
                    IF Y2<22 THEN
                     INC(Y2);
                    ELSE
                     IF N1>21 THEN WRITE(N1-21); END;
                    END;
                    Change(SHT,29,Y2,41,Y2);
                    Use(SHT);
                    Clear;
                    IO.WrStr(Mn2[N1]);
                   END;
            |72,75:IF N1>1 THEN
                    DEC(N1);
                    IF N1<22 THEN
                     DEC(Y2);
                    ELSE
                     IF N1>21 THEN WRITE(N1-21); END;
                    END;
                    Change(SHT,29,Y2,41,Y2);
                    Use(SHT);
                    Clear;
                    IO.WrStr(Mn2[N1]);
                   END;

           END;
          END;
          Close(WT[3]);
     |27: Change(SHT,1,Y,16,Y);
          Use(SHT);
          Clear;
          IO.WrStr(REC[N].Name1);
          EXIT;
     |0: C:=IO.RdKey();
          (*IO.WrCard(ORD(C),1);*)
          CASE ORD(C) OF
           |80,77:IF Y1<5 THEN
                   INC(Y1);
                   Change(SHT,20,Y1,26,Y1);
                   Use(SHT);
                   Clear;
                   IO.WrStr(Mn1[Y1]);
                  END;
           |72,75:IF Y1>1 THEN
                   DEC(Y1);
                   Change(SHT,20,Y1,26,Y1);
                   Use(SHT);
                   Clear;
                   IO.WrStr(Mn1[Y1]);
                  END;
         END;
   END;

    END;
    Close(WT[2]);
   END EDIT;


  BEGIN
   WINDOW(0,0,18,23,1);

   SHD.FrameOn:=FALSE;
   SHD.WrapOn:=TRUE;
   SHD.Hidden:=FALSE;
   SHD.Foreground:=Color(0);
   SHD.Background:=Color(7);
   SHD.X1:=1;
   SHD.Y1:=1;
   SHD.X2:=16;
   SHD.Y2:=1;
   SHT:=Open(SHD);

   IO.WrStr(REC[1].Name1);
   CursorOff;
   WRITE(1);
   Y:=1;N:=1;S:=36;
   LOOP
   C:=IO.RdKey();
   CASE ORD(C) OF
    |13: EDIT(N);
    |ORD("F"),ORD("f"):WINDOW(20,7,53,7,5);
                       IO.WrStr(' Имя геpоя:');IO.RdStr(ST);
                       IO.WrStr(' Подождите пожалуйста...');
                       D:=FindHero(ST);
                       IF D<S THEN
                       Close(WT[5]);
                       EDIT(D) ELSE
                       Clear;
                       IO.WrStr("Такого геpоя нет.");Delay(500);
                       Close(WT[5]);
                       END;
    |27: Close(WT[1]);
         Close(SHT);
         EXIT;
    |0: C:=IO.RdKey();
         (*IO.WrCard(ORD(C),1);*)
         CASE ORD(C) OF
          |80,77:IF N<S THEN
                  INC(N);
                  IF Y<22 THEN
                   INC(Y);
                  ELSE
                   IF N>21 THEN WRITE(N-21); END;
                  END;
                  Change(SHT,1,Y,16,Y);
                  Use(SHT);
                  Clear;
                  IO.WrStr(REC[N].Name1);
                 END;
          |72,75:IF N>1 THEN
                  DEC(N);
                  IF N<22 THEN
                   DEC(Y);
                  ELSE
                   IF N>21 THEN WRITE(N-21); END;
                  END;
                  Change(SHT,1,Y,16,Y);
                  Use(SHT);
                  Clear;
                  IO.WrStr(REC[N].Name1);
                 END;
         END;
   END;

   END;
   RETURN N;
  END Serch;

BEGIN
 ParamStr(PrStr,1);
 ParamStr(GRT,2);

 IF PrStr[1]='' THEN PrStr:="$.$" END;
 IF FIO.Exists(PrStr)=FALSE THEN
  IO.WrLn;
  IO.WrStr("        For V1.97 Heroes of Might&Magic Heroes Editor ");IO.WrLn;
  IO.WrStr("       ░▒▓ V1.00 Copyright (c) 1996 Mamonov Maksim.▓▒░ ");IO.WrLn;
  IO.WrLn;
  IO.WrLn;
  IO.WrStr("  HMM_EDIT позволяет изменять бонусы геpоя, тип и количество воинов.");
  IO.WrLn();
  IO.WrStr("  Usage:  HMM_EDIT <save name> (GREAT)");IO.WrLn();
  IO.WrStr("          (GREAT) - все геpои получают полный набоp лучших воинов. ");
 ELSE
  IF (GRT[1]='G') OR (GRT[1]='g') AND
     (GRT[2]='R') OR (GRT[2]='r') AND
     (GRT[3]='E') OR (GRT[3]='e') AND
     (GRT[4]='A') OR (GRT[4]='a') AND
     (GRT[5]='T') OR (GRT[5]='t') THEN
   F:=FIO.Open(PrStr);
   FIO.Seek(F,367);
   FIO.WrBin(F,800,4);
   FIO.WrBin(F,800,4);
   FIO.WrBin(F,800,4);
   FIO.WrBin(F,800,4);
   FIO.WrBin(F,800,4);
   FIO.WrBin(F,800,4);
   FIO.WrBin(F,65000,2);
   FIO.Seek(F,52841);
   D:=FIO.RdBin(F,REC,6552);
   FIO.Close(F);
   FOR D:=1 TO 36 DO
    REC[D].CA_1:=100;
    REC[D].A_1:=5;
    REC[D].CA_2:=100;
    REC[D].A_2:=11;
    REC[D].CA_3:=100;
    REC[D].A_3:=17;
    REC[D].CA_4:=100;
    REC[D].A_4:=23;
    REC[D].CA_5:=100;
    REC[D].A_5:=27;
    REC[D].B_A:=15;
    REC[D].B_D:=15;
    REC[D].B_M:=15;
    REC[D].B_K:=15;
   END;

  F:=FIO.Open(PrStr);
  FIO.Seek(F,52841);
  FIO.WrBin(F,REC,6552);
  FIO.Close(F);

  HALT;
  END;

  M_Main.OpenBck("▒",7,1);
  Use(M_Main.SHAT);
  IO.WrStr(" 'F' - Поиск по имени.   - Выбоp. Esс - Выход + запись.");

  F:=FIO.Open(PrStr);
  FIO.Seek(F,367);
  FIO.WrBin(F,800,4);
  FIO.WrBin(F,800,4);
  FIO.WrBin(F,800,4);
  FIO.WrBin(F,800,4);
  FIO.WrBin(F,800,4);
  FIO.WrBin(F,800,4);
  FIO.WrBin(F,65000,2);
  FIO.Seek(F,52841);
  D:=FIO.RdBin(F,REC,6552);
  FIO.Close(F);

  D:=Serch();
  M_Main.CloseBck;

  F:=FIO.Open(PrStr);
  FIO.Seek(F,52841);
  FIO.WrBin(F,REC,6552);
  FIO.Close(F);

 END;
END HMM_EDIT.
