MODULE tSysMove07;

IMPORT Out, SYSTEM;

VAR 
  a: ARRAY 10 OF INTEGER;
  i : INTEGER;

BEGIN
  FOR i := 0 TO 9 DO a[i]:= i END;
  SYSTEM.COPY(SYSTEM.ADR(a[2]), SYSTEM.ADR(a[4]), 4*SYSTEM.SIZE(INTEGER));
  FOR i := 0 TO 9 DO Out.Int(a[i], 2) END;
  Out.Ln
END tSysMove07.

(*<<
 0 1 2 3 2 3 4 5 8 9
>>*)

(*[[
!! SYMFILE #tSysMove07 STAMP #tSysMove07.%main 1
!! END STAMP
!! 
MODULE tSysMove07 STAMP 0
IMPORT Out STAMP
ENDHDR

PROC tSysMove07.%main 0 5 0
!   FOR i := 0 TO 9 DO a[i]:= i END;
CONST 0
STGW tSysMove07.i
LABEL L1
LDGW tSysMove07.i
CONST 9
JGT L2
LDGW tSysMove07.i
GLOBAL tSysMove07.a
LDGW tSysMove07.i
CONST 10
BOUND 10
STIW
LDGW tSysMove07.i
INC
STGW tSysMove07.i
JUMP L1
LABEL L2
!   SYSTEM.COPY(SYSTEM.ADR(a[2]), SYSTEM.ADR(a[4]), 4*SYSTEM.SIZE(INTEGER));
CONST 16
GLOBAL tSysMove07.a
CONST 16
PLUSA
GLOBAL tSysMove07.a
CONST 8
PLUSA
GLOBAL SYSMOVE
CALL 3
!   FOR i := 0 TO 9 DO Out.Int(a[i], 2) END;
CONST 0
STGW tSysMove07.i
LABEL L3
LDGW tSysMove07.i
CONST 9
JGT L4
CONST 2
GLOBAL tSysMove07.a
LDGW tSysMove07.i
CONST 10
BOUND 12
LDIW
GLOBAL Out.Int
CALL 2
LDGW tSysMove07.i
INC
STGW tSysMove07.i
JUMP L3
LABEL L4
!   Out.Ln
GLOBAL Out.Ln
CALL 0
RETURN
END

! Global variables
GLOVAR tSysMove07.a 40
GLOVAR tSysMove07.i 4

! End of file
]]*)
