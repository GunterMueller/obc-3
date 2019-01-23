#
# makestubs.tcl
# 
# This file is part of the Oxford Oberon-2 compiler
# Copyright (c) 2006--2016 J. M. Spivey
# All rights reserved
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
# 3. The name of the author may not be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# Size of each kind in argument words
set size(C) 1
set size(I) 1
set size(F) 1
set size(P) 1
set size(L) 2
set size(D) 2
set size(X) 2
set size(Q) 2

proc scanfiles {fun fnames} {
    foreach fname $fnames {
        set fd [open $fname r]
        scan $fun $fd
        close $fd
    }
}

proc scan {fun fd} {
    while {[gets $fd line] >= 0} {
        if {[regexp {^PRIMDEF .* (.*) (.*)$} $line _ name tstring]} {
            $fun $name $tstring
        }
    }
}

set prims {}

proc defprim {name tstring} {
    global size
    global prims
    
    if {$tstring == "*"} {
        puts "void ${name}(value *bp);\n"
        lappend prims $name
    } else {
        set proto 1
        if {[string index $name 0] == "="} {
            set proto 0
            set name [string range $name 1 end]
        }

        set spec [split $tstring ""]
        set rtype [lindex $spec 0]
        set args [lrange $spec 1 end]

        set off 0
        set alist {}
        set blist {}
        if {[llength $args] == 0} {
            set blist "void"
        } else {
            foreach x $args {
                lappend alist "arg_${x}($off)"
                lappend blist "type_$x"
                incr off $size($x)
            }
        }
        
        set astring [join $alist ", "]
        set bstring [join $blist ", "]

        if {$proto} {
            puts "type_$rtype ${name}($bstring);\n"
        }

        puts "value *P_${name}(value *bp) {"
        puts "     value *sp = bp;"
        puts "     FPINIT;"
        puts "     res_${rtype}(${name}($astring));"
        puts "     return sp;"
        puts "}\n"

        lappend prims "P_$name"
    }
}

puts "/* Generated by makestubs */\n"

puts "#include \"primtab.h\""
puts "#include <stdio.h>\n"

scanfiles defprim $argv

puts "#ifndef DYNLINK"
puts "struct primdef primtab\[\] = {"
foreach p $prims {
    puts "     { \"$p\", $p },"
}
puts "     { NULL, NULL }"
puts "};"
puts "#endif"
