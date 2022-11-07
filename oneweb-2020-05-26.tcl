#
# * OneWeb constellation
# * Based on pervious work by Greg Wyler
#
# * Based on the Schedule S FCC filing in SAT-MPL-20200526-00062
#

# setup orbital elements
set a [expr 1200.0+$RADIUS_OF_EARTH]

set coverage_angle 45.0

# compute period of orbit
set T_per [expr 2 * $PI * pow($a,1.5) / sqrt($MU)]


satellites GV_BEGIN

# 87.9 degree inclination orbital planes
set SATS_PER_PLANE 49
set NUM_PLANES 12
set INTERPLANE_SPACING 15.23

set e 0.0
set inc 87.9
set omega 0.0

for {set j 0} {$j < $NUM_PLANES} {incr j} {
	set Omega [expr $j * $INTERPLANE_SPACING]
	for {set i 0} {$i < $SATS_PER_PLANE} {incr i} {
		if { $j % 2 == 0} {
			set plane_offset 0
		} else {
			set plane_offset [expr $T_per / $SATS_PER_PLANE / 2.0]
		}
		set T [expr $T_per * $i / $SATS_PER_PLANE + $plane_offset]
		set n [satellites LOAD $a $e $inc $Omega $omega $T "OneWeb 87 ($j, $i)"]
		if {$i > 0} {satellites ORBIT_SET $n 0}
	}
}

# 55.0 degree inclination orbital planes
set SATS_PER_PLANE 16
set NUM_PLANES 8
set INTERPLANE_SPACING 45.0

set e 0.0
set inc 55.0
set omega 0.0

for {set j 0} {$j < $NUM_PLANES} {incr j} {
	set Omega [expr $j * $INTERPLANE_SPACING]
	for {set i 0} {$i < $SATS_PER_PLANE} {incr i} {
		if { $j % 2 == 0} {
			set plane_offset 0
		} else {
			set plane_offset [expr $T_per / $SATS_PER_PLANE / 2.0]
		}
		set T [expr $T_per * $i / $SATS_PER_PLANE + $plane_offset]
		set n [satellites LOAD $a $e $inc $Omega $omega $T "OneWeb 55 ($j, $i)"]
		if {$i > 0} {satellites ORBIT_SET $n 0}
	}
}

satellites GV_END

