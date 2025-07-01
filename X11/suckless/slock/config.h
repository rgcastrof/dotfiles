/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "users";
/*Font settings for the time text*/
static const float textsize=64.0;
static const char* textfamily="CaskaydiaCoveNerdFont";
static const double textcolorred=255;
static const double textcolorgreen=255;
static const double textcolorblue=255;

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
