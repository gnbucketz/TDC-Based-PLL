proc run_imp {} {
    launch_runs impl_1
    wait_on_run impl_1
    open_run impl_1
}

proc clock_report {} {
    #clock regions used and BUFG/BUFH usage
    report_clock_utilization -file clock_util.rpt
    #module usage
    report_utilization -hierarchical -file util_hier.rpt
    report_timing_summary -file timing.rpt
}

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

proc hierarchy {fh} {
    set child {}
    set cellDict {}
    set slr_counter 0
    set cr_counter 0
    set tile_counter 0
    set allTiles [get_tiles]
    set allTileCount [llength $allTiles]

    set slrList [get_slrs]
    if {[llength $slrList] == 0} {
        puts $fh "No SLRs found"
    }

    foreach slr $slrList {
        dict set child $slr {}
        incr slr_counter
        
        set crList [get_clock_regions -of_objects $slr]
        if {[llength $crList] == 0} {
            puts $fh "No CRs found" 
        }

        foreach cr $crList {
            dict set child $slr $cr {}
            incr cr_counter
            
            set tileList [get_tiles -of_objects $cr]
            if {[llength $tileList] == 0} {
                puts $fh "No tiles found"
            }

            foreach tile $tileList {
                incr tile_counter 
                }
            }
        } 

    set cellList [get_cells -hier]
    set cellCount [llength $cellList]
    set type [lsort -unique $typeList]

    set typeList {}
    foreach cell $cellList {
        lappend typeList [get_property REF_NAME $cell]
    }
    
    set typeCount {}
    foreach uniqueType $typeList {
        dict incr typeCount $uniqueType
    }
    dict for {cellName count} $typeCount {
        puts $fh "Unique Cell: ${cellName}: $count"
    }
    
    puts $fh "Dict: $child"
    puts $fh "Total SLRs: $slr_counter"
    puts $fh "Total Clock Regions: $cr_counter"
    puts $fh "Total Tiles: $tile_counter"
    puts $fh "Cell Count: $cellCount"
    puts $fh "Cell Types: $type"
    return $child
}
proc main {} {
    set fh [open "debug.txt" "w"]
    #use 10ns as top level clk
    create_clock -name clk_in -period 10.000 [get_ports clk] 
    #we need delay for signals coming/goes from outside the FPGA
    set_input_delay -clock clk_in 2.0 [get_ports ref_sig]
    set_output_delay -clock clk_in 2.0 [get_ports pll_out]
    #ignoring false error from ext_rst
    set_false_path -from [get_ports ext_rst]

    deviceInfo $fh
    hierarchy $fh

    close $fh
}