//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", "~/.dwmblocks/SSID.sh", 5, 0},
	{"", "~/.dwmblocks/volume.sh" , 1,  0},
	{"", "~/.dwmblocks/battery.sh", 10, 0},
	{"|  ", "date +'%b %d  %H:%M'",		30,		0},

	/* Updates whenever "pkill -SIGRTMIN+10 someblocks" is ran */
	/* {"", "date '+%b %d (%a) %I:%M%p'",					0,		10}, */
};



//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 5;
