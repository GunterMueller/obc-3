MODULE tOpen;

(*<<
15
>>*)

IMPORT Out;

PROCEDURE Sum(a: ARRAY OF INTEGER): INTEGER;
  VAR i, s: INTEGER;
BEGIN
  s := 0;
  FOR i := 0 TO LEN(a)-1 DO s := s + a[i] END;
  RETURN s
END Sum;

VAR b: ARRAY 5 OF INTEGER;

PROCEDURE Main;
VAR j: INTEGER;
BEGIN
  FOR j := 0 TO LEN(b)-1 DO b[j] := j+1 END
END Main;

BEGIN
  Main;
  Out.Int(Sum(b), 0); Out.Ln
END tOpen.

(*[[
!! (SYMFILE #tOpen STAMP #tOpen.%main 1)
!! (CHKSUM STAMP)
!! 
MODULE tOpen STAMP 0
IMPORT Out STAMP
ENDHDR

PROC tOpen.Sum 12 4 0
FRAME
! PROCEDURE Sum(a: ARRAY OF INTEGER): INTEGER;
LOCAL 12
LDLW 16
CONST 4
TIMES
FLEXCOPY
!   s := 0;
CONST 0
STLW -8
!   FOR i := 0 TO LEN(a)-1 DO s := s + a[i] END;
LDLW 16
DEC
STLW -12
CONST 0
STLW -4
LABEL L1
LDLW -4
LDLW -12
JGT L2
LDLW -8
LDLW 12
LDLW -4
LDLW 16
BOUND 13
LDIW
PLUS
STLW -8
INCL -4
JUMP L1
LABEL L2
!   RETURN s
LDLW -8
RETURN
END

PROC tOpen.Main 4 4 0
FRAME
! PROCEDURE Main;
!   FOR j := 0 TO LEN(b)-1 DO b[j] := j+1 END
CONST 0
STLW -4
LABEL L3
LDLW -4
CONST 4
JGT L4
LDLW -4
INC
GLOBAL tOpen.b
LDLW -4
CONST 5
BOUND 22
STIW
INCL -4
JUMP L3
LABEL L4
RETURN
END

PROC tOpen.%main 0 5 0
!   Main;
GLOBAL tOpen.Main
CALL 0
!   Out.Int(Sum(b), 0); Out.Ln
CONST 0
CONST 5
GLOBAL tOpen.b
GLOBAL tOpen.Sum
CALLW 2
GLOBAL Out.Int
CALL 2
GLOBAL Out.Ln
CALL 0
RETURN
END

! Global variables
GLOVAR tOpen.b 20

! End of file
]]*)
