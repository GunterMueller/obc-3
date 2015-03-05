MODULE tGC507;

IMPORT Out, GC;

CONST N = 1000;

CONST a = 3141592; b = 1618033; M = 2718281;

VAR seed: INTEGER;

PROCEDURE Random(N: INTEGER): INTEGER;
BEGIN
  seed := (seed * a + b) MOD M;
  RETURN seed MOD N
END Random;

TYPE tree = POINTER TO cell;
  cell = RECORD key, value: INTEGER; left, right: tree END;

PROCEDURE Size(t: tree): INTEGER;
VAR s: INTEGER;
BEGIN
  IF t = NIL THEN
s :=  0
  ELSE
s:= t.value + Size(t.left) + Size(t.right)
  END
RETURN s
END Size;

PROCEDURE Cons(key, value: INTEGER; left, right: tree): tree;
  VAR t: tree;
BEGIN
  NEW(t);
  t.key := key; t.value := value;
  t.left := left; t.right := right;
  RETURN t
END Cons;

PROCEDURE Increment(key: INTEGER; t: tree): tree;
BEGIN
  IF t = NIL THEN
t := Cons(key, 1, NIL, NIL)
  ELSIF key = t.key THEN
t:= Cons(key, t.value+1, t.left, t.right)
  ELSIF key < t.key THEN
t:= Cons(t.key, t.value, Increment(key, t.left), t.right)
  ELSE
t:= Cons(t.key, t.value, t.left, Increment(key, t.right))
  END
RETURN t
END Increment;
    
PROCEDURE Ordered(t: tree; lo, hi: INTEGER): BOOLEAN;
RETURN
  (t = NIL) OR ((lo <= t.key) & (t.key < hi) 
	& Ordered(t.left, lo, t.key)
	& Ordered(t.right, t.key+1, hi))
END Ordered;

VAR 
  i: INTEGER;
  t: tree;

CONST K = 50000;

BEGIN
  GC.Debug("s");

  t := NIL;
  FOR i := 1 TO K DO
    t := Increment(Random(100), t)
  END;
  Out.Int(Size(t), 0); Out.Ln;
  IF Ordered(t, 0, 100) THEN Out.String("ordered"); Out.Ln END;
  Out.Int(GC.HeapSize(), 0); Out.Ln
END tGC507.

(*<<
50000
ordered
2097152
>>*)

(*[[
!! SYMFILE #tGC507 STAMP #tGC507.%main 1
!! END STAMP
!! 
MODULE tGC507 STAMP 0
IMPORT Out STAMP
IMPORT GC STAMP
ENDHDR

PROC tGC507.Random 0 2 0
! PROCEDURE Random(N: INTEGER): INTEGER;
!   seed := (seed * a + b) MOD M;
LDGW tGC507.seed
CONST 3141592
TIMES
CONST 1618033
PLUS
CONST 2718281
MOD
STGW tGC507.seed
!   RETURN seed MOD N
LDGW tGC507.seed
LDLW 12
ZCHECK 14
MOD
RETURNW
END

PROC tGC507.Size 4 3 0x00100001
! PROCEDURE Size(t: tree): INTEGER;
!   IF t = NIL THEN
LDLW 12
JNEQZ 5
! s :=  0
CONST 0
STLW -4
JUMP 3
LABEL 5
! s:= t.value + Size(t.left) + Size(t.right)
LDLW 12
NCHECK 26
LDNW 4
LDLW 12
NCHECK 26
LDNW 8
GLOBAL tGC507.Size
CALLW 1
PLUS
LDLW 12
NCHECK 26
LDNW 12
GLOBAL tGC507.Size
CALLW 1
PLUS
STLW -4
LABEL 3
! RETURN s
LDLW -4
RETURNW
END

PROC tGC507.Cons 4 4 0x00c10001
! PROCEDURE Cons(key, value: INTEGER; left, right: tree): tree;
!   NEW(t);
CONST 16
GLOBAL tGC507.cell
LOCAL -4
GLOBAL NEW
CALL 3
!   t.key := key; t.value := value;
LDLW 12
LDLW -4
NCHECK 35
STOREW
LDLW 16
LDLW -4
NCHECK 35
STNW 4
!   t.left := left; t.right := right;
LDLW 20
LDLW -4
NCHECK 36
STNW 8
LDLW 24
LDLW -4
NCHECK 36
STNW 12
!   RETURN t
LDLW -4
RETURNW
END

PROC tGC507.Increment 0 5 0x00200001
! PROCEDURE Increment(key: INTEGER; t: tree): tree;
!   IF t = NIL THEN
LDLW 16
JNEQZ 8
! t := Cons(key, 1, NIL, NIL)
CONST 0
CONST 0
CONST 1
LDLW 12
GLOBAL tGC507.Cons
CALLW 4
STLW 16
JUMP 6
LABEL 8
!   ELSIF key = t.key THEN
LDLW 12
LDLW 16
NCHECK 44
LOADW
JNEQ 10
! t:= Cons(key, t.value+1, t.left, t.right)
LDLW 16
NCHECK 45
LDNW 12
LDLW 16
NCHECK 45
LDNW 8
LDLW 16
NCHECK 45
LDNW 4
INC
LDLW 12
GLOBAL tGC507.Cons
CALLW 4
STLW 16
JUMP 6
LABEL 10
!   ELSIF key < t.key THEN
LDLW 12
LDLW 16
NCHECK 46
LOADW
JGEQ 12
! t:= Cons(t.key, t.value, Increment(key, t.left), t.right)
LDLW 16
NCHECK 47
LDNW 12
LDLW 16
NCHECK 47
LDNW 8
LDLW 12
GLOBAL tGC507.Increment
STKMAP 0x00000009
CALLW 2
LDLW 16
NCHECK 47
LDNW 4
LDLW 16
NCHECK 47
LOADW
GLOBAL tGC507.Cons
CALLW 4
STLW 16
JUMP 6
LABEL 12
! t:= Cons(t.key, t.value, t.left, Increment(key, t.right))
LDLW 16
NCHECK 49
LDNW 12
LDLW 12
GLOBAL tGC507.Increment
CALLW 2
LDLW 16
NCHECK 49
LDNW 8
LDLW 16
NCHECK 49
LDNW 4
LDLW 16
NCHECK 49
LOADW
GLOBAL tGC507.Cons
CALLW 4
STLW 16
LABEL 6
! RETURN t
LDLW 16
RETURNW
END

PROC tGC507.Ordered 0 5 0x00100001
! PROCEDURE Ordered(t: tree; lo, hi: INTEGER): BOOLEAN;
!   (t = NIL) OR ((lo <= t.key) & (t.key < hi) 
LDLW 12
JEQZ 14
LDLW 16
LDLW 12
NCHECK 56
LOADW
JGT 15
LDLW 12
NCHECK 56
LOADW
LDLW 20
JGEQ 15
LDLW 12
NCHECK 57
LOADW
LDLW 16
LDLW 12
NCHECK 57
LDNW 8
GLOBAL tGC507.Ordered
CALLW 3
JUMPF 15
LDLW 20
LDLW 12
NCHECK 58
LOADW
INC
LDLW 12
NCHECK 58
LDNW 12
GLOBAL tGC507.Ordered
CALLW 3
JUMPF 15
LABEL 14
CONST 1
RETURNW
LABEL 15
CONST 0
RETURNW
END

PROC tGC507.%main 0 5 0
!   GC.Debug("s");
CONST 2
GLOBAL tGC507.%2
GLOBAL GC.Debug
CALL 2
!   t := NIL;
CONST 0
STGW tGC507.t
!   FOR i := 1 TO K DO
CONST 1
STGW tGC507.i
LABEL 21
LDGW tGC507.i
CONST 50000
JGT 22
!     t := Increment(Random(100), t)
LDGW tGC507.t
CONST 100
GLOBAL tGC507.Random
STKMAP 0x00000005
CALLW 1
GLOBAL tGC507.Increment
CALLW 2
STGW tGC507.t
!   FOR i := 1 TO K DO
LDGW tGC507.i
INC
STGW tGC507.i
JUMP 21
LABEL 22
!   Out.Int(Size(t), 0); Out.Ln;
CONST 0
LDGW tGC507.t
GLOBAL tGC507.Size
CALLW 1
GLOBAL Out.Int
CALL 2
GLOBAL Out.Ln
CALL 0
!   IF Ordered(t, 0, 100) THEN Out.String("ordered"); Out.Ln END;
CONST 100
CONST 0
LDGW tGC507.t
GLOBAL tGC507.Ordered
CALLW 3
JUMPF 25
CONST 8
GLOBAL tGC507.%1
GLOBAL Out.String
CALL 2
GLOBAL Out.Ln
CALL 0
LABEL 25
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
GLOVAR tGC507.seed 4
GLOVAR tGC507.i 4
GLOVAR tGC507.t 4

! Pointer map
DEFINE tGC507.%gcmap
WORD GC_BASE
WORD tGC507.t
WORD 0
WORD GC_END

! String "ordered"
DEFINE tGC507.%1
STRING 6F72646572656400

! String "s"
DEFINE tGC507.%2
STRING 7300

! Descriptor for cell
DEFINE tGC507.cell
WORD 0x00000019
WORD 0
WORD tGC507.cell.%anc

DEFINE tGC507.cell.%anc
WORD tGC507.cell

! End of file
]]*)
