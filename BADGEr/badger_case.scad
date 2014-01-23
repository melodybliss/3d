/*
** File:		badger_case.scad
** Author:	Melody Bliss <melody@melodybliss.org>
** Purpose:
**	This is a case for the BADGEr_v4.1 eInk badge from Seeedstudio
** at http://www.seeedstudio.com/depot/badgerv4-p-1587.html
**
** This uses 1/4" x 1/16" neodymium magnets to hold the front and rear covers together.
*/

board_thickness=1.5;			// How thick is the board
badger_width=102;			// Width of the badger_v4.1
badger_height=67;			// Height of the badger (not including the "ears")
case_width=badger_width + 2;	// badger_width + 2mm
case_height=badger_height + 2;	// badger_height + 2mm
back_depth=8;				// How deep is the back case portion?
case_depth=1;				// depth of the case
ear_width=15;				// width of "ears" (badge holder section)
ear_height=15;				// height of "ears"
ear_thickness=board_thickness + .5;			// how thick are the ears? Make it .5 thicker to compenstate
mh_diameter=3;				// diameter of mounting holes
mh_diameter=4;				// diameter of mounting holes
battery_width=28;			// Width of battery compartment
battery_height=25;			// battery height
battery_start=20;			// Start of the battery location (X)
battery_depth=8;
power_start=56;				// Power start location
power_width=9;				// width of the power switch
power_height=4;				// Power switch height
power_y=58;					// Power Y location
uSD_Y=42.5;					// microSD slot start (Y)
uSD_height=15;				// height of uSD slot
uSD_width=17.5;				// width of uSD slot
uSD_depth=4;					// uSD depth

magnet_width=6.5;			// 1/4"
magnet_depth=1.8;			// 1/16"

display_width=71;			// width of the display
display_height=46;			// height of the display
display_X=16.5;				// X start of the display
display_Y=17;				// Y start of the display
button_size=6;				// size of the buttons
button_depth=6.5;			// depth of the buttons
button_Y=3;					// button Y location
button_X=[32.3, 42.3, 52.5, 62.7, 78];	// X locations of the buttons
top_depth=6.5;

header_width=16;				// Width of the headers on the bottom
header_length=10;
header_depth=4;
header_X=15;					// X start of the header

led_X = case_width - ((case_width - badger_width)/2) - 6.0;
led_Y=42;
led_width=2.5;
led_height=1.5;

module case_back_no_ears()
{
	difference()
	{
		cube([case_width, case_height, back_depth + case_depth]);
		translate([(case_width - badger_width)/2, (case_height - badger_height) / 2, case_depth])
			cube([badger_width, badger_height, back_depth]);
	}

	// For each mount home, make the length just shy of the true thickness of the back allowing the board to
	// rest on the hole
	// first mount hole - left side
	translate([((case_width - badger_width)/2) + 3, 20.25, 0])
		cylinder(r=mh_diameter/2, h=back_depth + case_depth - board_thickness);
	// second mount hole - left side
	translate([((case_width - badger_width)/2) + 3, 47.75, 0])
		cylinder(r=mh_diameter/2, h=back_depth + case_depth - board_thickness);
	// third mount hole - first right side
	translate([case_width - ((case_width - badger_width)/2 + 3), 20.25, 0])
		cylinder(r=mh_diameter/2, h=back_depth + case_depth - board_thickness);

	// fourth mount hole - middle just below display
	translate([case_width - ((case_width - badger_width)/2 + 47), 15, 0])
		cylinder(r=mh_diameter/2, h=back_depth + case_depth - board_thickness);

	// fifth mount hole - middle just above display
	translate([case_width - ((case_width - badger_width)/2 + 47), 63, 0])
		cylinder(r=mh_diameter/2, h=back_depth + case_depth - board_thickness);
}

module case_back()
{
	difference()
	{
		case_back_no_ears();
		// left "ear"
		translate([(case_width - badger_width) / 2, badger_height, back_depth])
			cube([ear_width, ear_height, ear_thickness]);
		// right "ear"
		translate([case_width - ((case_width - badger_width) / 2) - ear_width, badger_height, back_depth])
			cube([ear_width, ear_height, ear_thickness]);
		// battery opening
		translate([battery_start + ((case_width - badger_width)/2), badger_height, case_depth])
			cube([battery_width, battery_height, battery_depth]);
		// Power switch opening
		translate([power_start + ((case_width - badger_width)/2), power_y + ((case_height - badger_height)/2), 0])
			cube([power_width, power_height, case_depth]);
		// uSD slot opening
		translate([badger_width, uSD_Y + ((case_height - badger_height)/2), back_depth + case_depth - uSD_depth])
		cube([uSD_width, uSD_height, uSD_depth]);

		// header opening
		translate([((case_width - badger_width)/2) + header_X, 0, back_depth + case_depth - header_depth])
			cube([header_width, header_length, header_depth]);
}
	
	// bottom left magnet
	translate([((case_width - badger_width)/2) + magnet_width, 
			   ((case_height - badger_height)/2) + magnet_width, 
				0])
	difference()
	{
			cylinder(r=(magnet_width/2) + 2, h=back_depth+case_depth);
			translate([0,0, back_depth + case_depth - magnet_depth])
				cylinder(r=(magnet_width/2), h = magnet_depth);
	}
	// bottom right magnet
	translate([case_width - ((case_width - badger_width)/2) - magnet_width, 
			   ((case_height - badger_height)/2) + magnet_width, 
				0])
	difference()
	{
			cylinder(r=(magnet_width/2) + 2, h=back_depth+case_depth);
			translate([0,0, back_depth + case_depth - magnet_depth])
				cylinder(r=(magnet_width/2), h = magnet_depth);
	}
}

module case_top_with_magnets()
{
	difference()
	{
		cube([case_width, case_height, top_depth + case_depth]);
		translate([(case_width - badger_width)/2, (case_height - badger_height) / 2, 0])
			cube([badger_width, badger_height, top_depth]);
	}

	// bottom left magnet
	translate([((case_width - badger_width)/2) + magnet_width, 
			   ((case_height - badger_height)/2) + magnet_width, 
				0])
	difference()
	{
			cylinder(r=(magnet_width/2) + 2, h=top_depth+case_depth);
				cylinder(r=(magnet_width/2), h = magnet_depth);
	}

	// bottom right magnet
	translate([case_width - ((case_width - badger_width)/2) - magnet_width, 
			   ((case_height - badger_height)/2) + magnet_width, 
				0])
	difference()
	{
			cylinder(r=(magnet_width/2) + 2, h=top_depth+case_depth);
				cylinder(r=(magnet_width/2), h = magnet_depth);
	}

}

module case_top()
{
	difference()
	{
		case_top_with_magnets();
		// Display opening
		translate([display_X, display_Y, 0])
		cube([display_width, display_height, top_depth + case_depth]);

		// Button openings
		for(bx = button_X)
		{
			echo(str("bx=",bx));
			translate([bx, button_Y, 0])
				cube([button_size, button_size, top_depth + case_depth]);
		}

		// led opening
		translate([led_X, led_Y, 0])
			cube([led_width, led_height, top_depth + case_depth]);
	}
}

// Generate Back of the case. Shift by 5 so the two case halves aren't touching
translate([0,5,0]) case_back();

// Generate front of the case

//translate([0, 0, top_depth + case_depth]) rotate([180,0,0])
//	case_top();
