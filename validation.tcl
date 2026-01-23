proc deviceInfo {fh} {
    set boardName [get_property BOARD_PART [current_project]]
    set partName [get_property PART [current_project]]
    set hwDevice [get_hw_devices]

    if {[regexp {:([^:]*)\:} $boardName -> boardShort]} {
    }

    if {[llength $hwDevice] == 0} {
        puts $fh "No hardware device connected or found"
    } else {
        puts $fh "Device: $hwDevice"
    }
        
    if {[llength $boardName] == 0} {
        puts $fh "No board found"
    } else {
        puts $fh "Board: $boardShort"
    }
    if {[llength $partName] == 0} {
        puts $fh "No part found"
    } else {
        puts $fh "Part: $partName"
    }
}

proc slr {} {
    set child {}
    set fh [open "debug.txt" "w"]
    set slrList [get_slrs]
    set crList [get_clock_regions -of_objects $slrList]
    set tileList [get_tiles -of_objects $crList]
    set slr_counter 0
    set cr_counter 0
    set tile_counter 0

    deviceInfo $fh

    foreach slr $slrList {
        dict set child $slrList {}
        incr slr_counter
        if {[llength $slrList] == 0} {
            puts $fh "No SLRs found"
            }
        foreach cr $crList {
            dict set child $slrList $crList {}
            incr cr_counter
                if {[llength $crList] == 0} {
                    puts $fh "No CRs found" 
            }
            foreach tile $tileList {
                incr tile_counter 
                if {[llength $tileList] == 0} {

                }
                }
            }
        } 
    puts $fh "Dict: $child"
    puts $fh "Total SLRs: $slr_counter"
    puts $fh "Total Clock Regions: $cr_counter"
    puts $fh "Total Tiles: $tile_counter"
    close $fh
    return $child
}

