MODULE tFNeg07;

(*<<
-8.50940
>>*)

IMPORT Out;

VAR f: REAL;

BEGIN
  f := 2.71;
  f := 3.14 * (-f);
  Out.Real(f, 0); Out.Ln
END tFNeg07.

(*[[
!! (SYMFILE #tFNeg07 STAMP #tFNeg07.%main 1 #tFNeg07.m)
!! (CHKSUM STAMP)
!! 
MODULE tFNeg07 STAMP 0
IMPORT Out STAMP
ENDHDR

PROC tFNeg07.%main 0 3 0
!   f := 2.71;
FCONST 2.71
STGF tFNeg07.f
!   f := 3.14 * (-f);
LDGF tFNeg07.f
FUMINUS
FCONST 3.14
FTIMES
STGF tFNeg07.f
!   Out.Real(f, 0); Out.Ln
CONST 0
LDGF tFNeg07.f
GLOBAL Out.Real
CALL 2
GLOBAL Out.Ln
CALL 0
RETURN
END

! Global variables
GLOVAR tFNeg07.f 4

! End of file
]]*)
