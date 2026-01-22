proc slr {} {
    set child {}
    set fh [open "debug.txt" "w"]
    set slr [get_slrs]
    set cr [get_clock_regions -of_objects $slr]
    set tile [get_tiles -of_objects $cr]
    set slr_counter 0
    set cr_counter 0
    set tile_counter 0

    foreach slr $slr {
        dict set child $slr {}
        incr slr_counter
        if {[llength $slr] == 0} {
            puts $fh "No SLRs found"
            }
        foreach cr $cr {
            dict set child $slr $cr {}
            incr cr_counter
                if {[llength $cr] == 0} {
                puts $fh "No CRs found" 
            }
            foreach tile $tile {
                incr tile_counter 
                }
            }
        } 
   
    puts $fh $child
    puts $fh "Total SLRs: $slr_counter"
    puts $fh "Total Clock Regions: $cr_counter"
    puts $fh "Total Tiles: $tile_counter"
    close $fh
    return $child
}

