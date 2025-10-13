/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "users";
/*Font settings for the time text*/
static const float textsize=42.0;
static const char* textfamily="Noto Sans";
static const double textcolorred=255;
static const double textcolorgreen=255;
static const double textcolorblue=255;

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#1B1B1B",     /* after initialization */
	[INPUT] =  "#1976D2",   /* during input */
	[FAILED] = "#D50000",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
