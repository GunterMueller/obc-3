MODULE tGC207;

(*<<
500500
2097152
>>*)

IMPORT Out, GC;

TYPE ptr = POINTER TO cell;
  cell = RECORD hd: INTEGER; tl: ptr END;

PROCEDURE Reverse(a: ptr): ptr;
BEGIN
  IF a = NIL THEN
    a := NIL
  ELSE
    a := Snoc(Reverse(a.tl), a.hd)
  END
RETURN a
END Reverse;

PROCEDURE Snoc(a: ptr; x: INTEGER): ptr;
  VAR r: ptr;
BEGIN
  NEW(r);
  IF a = NIL THEN
    r.hd := x; r.tl := NIL
  ELSE
    r.hd := a.hd; r.tl := Snoc(a.tl, x)
  END;
  RETURN r
END Snoc;

PROCEDURE Sum(a: ptr): INTEGER;
VAR s: INTEGER;
BEGIN
  IF a = NIL THEN
s :=  0
  ELSE
s := a.hd + Sum(a.tl)
  END
RETURN s
END Sum;

VAR n: INTEGER; a: ptr;

BEGIN
  a := NIL;
  FOR n := 1 TO 1000 DO a := Snoc(a, n) END;
  Out.Int(Sum(Reverse(a)), 0); Out.Ln;
  Out.Int(GC.HeapSize(), 0); Out.Ln
END tGC207.

(*[[
!! (SYMFILE #tGC207 STAMP #tGC207.%main 1)
!! (CHKSUM STAMP)
!! 
MODULE tGC207 STAMP 0
IMPORT Out STAMP
IMPORT GC STAMP
ENDHDR

PROC tGC207.Reverse 0 3 0x00100001
! PROCEDURE Reverse(a: ptr): ptr;
!   IF a = NIL THEN
LDLW 12
JNEZ L3
!     a := NIL
CONST 0
STLW 12
JUMP L1
LABEL L3
!     a := Snoc(Reverse(a.tl), a.hd)
LDLW 12
NCHECK 18
LOADW
LDLW 12
NCHECK 18
LDNW 4
GLOBAL tGC207.Reverse
CALLW 1
GLOBAL tGC207.Snoc
CALLW 2
STLW 12
LABEL L1
! RETURN a
LDLW 12
RETURNW
END

PROC tGC207.Snoc 4 3 0x00110001
! PROCEDURE Snoc(a: ptr; x: INTEGER): ptr;
!   NEW(r);
CONST 8
GLOBAL tGC207.cell
GLOBAL NEW
CALLW 2
STLW -4
!   IF a = NIL THEN
LDLW 12
JNEZ L6
!     r.hd := x; r.tl := NIL
LDLW 16
LDLW -4
NCHECK 28
STOREW
CONST 0
LDLW -4
NCHECK 28
STNW 4
JUMP L4
LABEL L6
!     r.hd := a.hd; r.tl := Snoc(a.tl, x)
LDLW 12
NCHECK 30
LOADW
LDLW -4
NCHECK 30
STOREW
LDLW 16
LDLW 12
NCHECK 30
LDNW 4
GLOBAL tGC207.Snoc
CALLW 2
LDLW -4
NCHECK 30
STNW 4
LABEL L4
!   RETURN r
LDLW -4
RETURNW
END

PROC tGC207.Sum 4 3 0x00100001
! PROCEDURE Sum(a: ptr): INTEGER;
!   IF a = NIL THEN
LDLW 12
JNEZ L9
! s :=  0
CONST 0
STLW -4
JUMP L7
LABEL L9
! s := a.hd + Sum(a.tl)
LDLW 12
NCHECK 41
LOADW
LDLW 12
NCHECK 41
LDNW 4
GLOBAL tGC207.Sum
CALLW 1
PLUS
STLW -4
LABEL L7
! RETURN s
LDLW -4
RETURNW
END

PROC tGC207.%main 0 3 0
!   a := NIL;
CONST 0
STGW tGC207.a
!   FOR n := 1 TO 1000 DO a := Snoc(a, n) END;
CONST 1
STGW tGC207.n
LABEL L10
LDGW tGC207.n
CONST 1000
JGT L11
LDGW tGC207.n
LDGW tGC207.a
GLOBAL tGC207.Snoc
CALLW 2
STGW tGC207.a
LDGW tGC207.n
INC
STGW tGC207.n
JUMP L10
LABEL L11
!   Out.Int(Sum(Reverse(a)), 0); Out.Ln;
CONST 0
LDGW tGC207.a
GLOBAL tGC207.Reverse
CALLW 1
GLOBAL tGC207.Sum
CALLW 1
GLOBAL Out.Int
CALL 2
GLOBAL Out.Ln
CALL 0
!   Out.Int(GC.HeapSize(), 0); Out.Ln
CONST 0
GLOBAL GC.HeapSize
CALLW 0
GLOBAL Out.Int
CALL 2
GLOBAL Out.Ln
CALL 0
RETURN
END

! Global variables
GLOVAR tGC207.n 4
GLOVAR tGC207.a 4

! Global pointer map
DEFINE tGC207.%gcmap
WORD GC_POINTER
WORD tGC207.a
WORD GC_END

! Descriptor for cell
DEFINE tGC207.cell
WORD 0x00000005
WORD 0
WORD tGC207.cell.%anc

DEFINE tGC207.cell.%anc
WORD tGC207.cell

! End of file
]]*)
