//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/

  // {"Mem ", "free -h | grep Mem | awk '{print $3}'", 1, 0},
  {"", "~/.dwmblocks/void-updates.sh", 3600, 10},
  {"", "~/.dwmblocks/telegramTray.sh", 3, 0},
  {"", "~/.dwmblocks/zaptray.sh", 3, 0},
  {"", "~/.dwmblocks/volume.sh", 1, 0},
  {"", "~/.dwmblocks/battery.sh", 10, 0},
  {"", "~/.dwmblocks/SSID.sh", 5, 0},
  {"", "~/.dwmblocks/date.sh", 30, 0},
  
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = "";
static unsigned int delimLen = 5;
