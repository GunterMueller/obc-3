MODULE tMob;

IMPORT Out;

TYPE Fun = PROCEDURE (): REAL;

PROCEDURE A(k: INTEGER; x1, x2, x3, x4, x5: Fun): REAL;
  PROCEDURE B(): REAL;
  BEGIN
    k := k-1;
    RETURN A(k, B, x1, x2, x3, x4)
  END B;
BEGIN
  IF k <= 0 THEN RETURN x4() + x5() ELSE RETURN B() END
END A;

PROCEDURE One(): REAL; BEGIN RETURN 1 END One;
PROCEDURE MOne(): REAL; BEGIN RETURN -1 END MOne;
PROCEDURE Zero(): REAL; BEGIN RETURN 0 END Zero;

BEGIN
  Out.Real(A(10, One, MOne, MOne, One, Zero)); Out.Ln
END tMob.

(*<<
-67.0000
>>*)

(*[[
!! (SYMFILE #tMob STAMP #tMob.%main 1)
!! (CHKSUM STAMP)
!! 
MODULE tMob STAMP 0
IMPORT Out STAMP
ENDHDR

PROC tMob.%1.B 4 13 0
LFRAME
!   PROCEDURE B(): REAL;
!     k := k-1;
LDLW -4
LDNW 12
DEC
LDLW -4
STNW 12
!     RETURN A(k, B, x1, x2, x3, x4)
LDLW -4
LDNW 44
LDLW -4
LDNW 40
LDLW -4
LDNW 36
LDLW -4
LDNW 32
LDLW -4
LDNW 28
LDLW -4
LDNW 24
LDLW -4
LDNW 20
LDLW -4
LDNW 16
LDLW -4
GLOBAL tMob.%1.B
LDLW -4
LDNW 12
GLOBAL tMob.A
CALLF 11
RETURN
END

PROC tMob.A 0 3 0
! PROCEDURE A(k: INTEGER; x1, x2, x3, x4, x5: Fun): REAL;
!   IF k <= 0 THEN RETURN x4() + x5() ELSE RETURN B() END
LDLW 12
JGTZ L4
LDLW 40
NCHECK 14
LDLW 44
LCALLF 0
LDLW 48
NCHECK 14
LDLW 52
LCALLF 0
FPLUS
RETURN
LABEL L4
GLOBAL tMob.%1.B
LOCAL 0
LCALLF 0
RETURN
END

PROC tMob.One 0 1 0
! PROCEDURE One(): REAL; BEGIN RETURN 1 END One;
FCONST 1.0
RETURN
END

PROC tMob.MOne 0 1 0
! PROCEDURE MOne(): REAL; BEGIN RETURN -1 END MOne;
FCONST -1.0
RETURN
END

PROC tMob.Zero 0 1 0
! PROCEDURE Zero(): REAL; BEGIN RETURN 0 END Zero;
FCONST 0.0
RETURN
END

PROC tMob.%main 0 13 0
!   Out.Real(A(10, One, MOne, MOne, One, Zero)); Out.Ln
CONST 0
GLOBAL tMob.Zero
CONST 0
GLOBAL tMob.One
CONST 0
GLOBAL tMob.MOne
CONST 0
GLOBAL tMob.MOne
CONST 0
GLOBAL tMob.One
CONST 10
GLOBAL tMob.A
CALLF 11
GLOBAL Out.Real
CALL 1
GLOBAL Out.Ln
CALL 0
RETURN
END

! End of file
]]*)
