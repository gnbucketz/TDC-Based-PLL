proc slr {} {
    set child {}
    set fh [open "debug.txt" "w"]
    set slr [get_slrs]
    set cr [get_clock_regions -of_objects $slr]

    foreach slr $slr {
        dict set child $slr {}
        if {[llength $slr] == 0} {
            puts $fh "No SLRs found"
            }
        foreach cr $cr {
            dict set child $slr $cr {}
                if {[llength $cr] == 0} {
                puts $fh "No CRs found" 
            }
        } 
    }
puts $fh $child
close $fh
return $child
}

