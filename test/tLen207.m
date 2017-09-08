MODULE tLen207;

IMPORT Out;

TYPE 
  t = POINTER TO ARRAY 10 OF ARRAY 20 OF INTEGER;
  f = POINTER TO ARRAY OF INTEGER;
  
VAR x: INTEGER;

PROCEDURE P(): INTEGER; BEGIN INC(x); RETURN 0 END P;

PROCEDURE Q(a: ARRAY OF ARRAY OF INTEGER);
BEGIN
  Out.Int(LEN(a[P()]), 0); Out.Ln
END Q;

PROCEDURE R(p: t);
BEGIN
  Out.Int(LEN(p^), 0); Out.Ln;
  Out.Int(LEN(p^, 1), 0); Out.Ln;
  Out.Int(LEN(p^[0]), 0); Out.Ln;
  Out.Int(LEN(p^[P()]), 0); Out.Ln
END R;

PROCEDURE S(p: f);
BEGIN
  Out.Int(LEN(p^), 0); Out.Ln
END S;

VAR 
  b: ARRAY 4 OF ARRAY 5 OF INTEGER;
  r: t;
  s: f;

BEGIN
  x := 0;
  Q(b);
  NEW(r); R(r);
  NEW(s, 13); S(s);
  Out.Int(x, 0); Out.Ln
END tLen207.

(*<<
5
10
20
20
20
13
2
>>*)

(*[[
!! (SYMFILE #tLen207 STAMP #tLen207.%main 1)
!! (CHKSUM STAMP)
!! 
MODULE tLen207 STAMP 0
IMPORT Out STAMP
ENDHDR

PROC tLen207.P 0 3 0
! PROCEDURE P(): INTEGER; BEGIN INC(x); RETURN 0 END P;
LDGW tLen207.x
INC
STGW tLen207.x
CONST 0
RETURNW
END

PROC tLen207.Q 0 4 0x00100001
! PROCEDURE Q(a: ARRAY OF ARRAY OF INTEGER);
!   Out.Int(LEN(a[P()]), 0); Out.Ln
CONST 0
LDLW 12
GLOBAL tLen207.P
STKMAP 0x00000003
CALLW 0
LDLW 16
BOUND 15
POP 1
POP 1
LDLW 20
GLOBAL Out.Int
CALL 2
GLOBAL Out.Ln
CALL 0
RETURN
END

PROC tLen207.R 0 4 0x00100001
! PROCEDURE R(p: t);
!   Out.Int(LEN(p^), 0); Out.Ln;
CONST 0
LDLW 12
NCHECK 20
POP 1
CONST 10
GLOBAL Out.Int
CALL 2
GLOBAL Out.Ln
CALL 0
!   Out.Int(LEN(p^, 1), 0); Out.Ln;
CONST 0
LDLW 12
NCHECK 21
POP 1
CONST 20
GLOBAL Out.Int
CALL 2
GLOBAL Out.Ln
CALL 0
!   Out.Int(LEN(p^[0]), 0); Out.Ln;
CONST 0
LDLW 12
NCHECK 22
POP 1
CONST 20
GLOBAL Out.Int
CALL 2
GLOBAL Out.Ln
CALL 0
!   Out.Int(LEN(p^[P()]), 0); Out.Ln
CONST 0
LDLW 12
NCHECK 23
GLOBAL tLen207.P
STKMAP 0x00000003
CALLW 0
CONST 10
BOUND 23
POP 1
POP 1
CONST 20
GLOBAL Out.Int
CALL 2
GLOBAL Out.Ln
CALL 0
RETURN
END

PROC tLen207.S 0 4 0x00100001
! PROCEDURE S(p: f);
!   Out.Int(LEN(p^), 0); Out.Ln
CONST 0
LDLW 12
NCHECK 28
LDNW -4
LDNW 4
GLOBAL Out.Int
CALL 2
GLOBAL Out.Ln
CALL 0
RETURN
END

PROC tLen207.%main 0 5 0
!   x := 0;
CONST 0
STGW tLen207.x
!   Q(b);
CONST 5
CONST 4
GLOBAL tLen207.b
GLOBAL tLen207.Q
CALL 3
!   NEW(r); R(r);
CONST 800
CONST 0
GLOBAL NEW
CALLW 2
STGW tLen207.r
LDGW tLen207.r
GLOBAL tLen207.R
CALL 1
!   NEW(s, 13); S(s);
CONST 13
CONST 1
CONST 4
CONST 0
GLOBAL NEWFLEX
CALLW 4
STGW tLen207.s
LDGW tLen207.s
GLOBAL tLen207.S
CALL 1
!   Out.Int(x, 0); Out.Ln
CONST 0
LDGW tLen207.x
GLOBAL Out.Int
CALL 2
GLOBAL Out.Ln
CALL 0
RETURN
END

! Global variables
GLOVAR tLen207.x 4
GLOVAR tLen207.b 80
GLOVAR tLen207.r 4
GLOVAR tLen207.s 4

! Global pointer map
DEFINE tLen207.%gcmap
WORD GC_POINTER
WORD tLen207.r
WORD GC_POINTER
WORD tLen207.s
WORD GC_END

! End of file
]]*)
