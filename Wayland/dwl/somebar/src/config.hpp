// somebar - dwl bar
// See LICENSE file for copyright and license details.

#pragma once
#include "common.hpp"

constexpr bool topbar = true;

constexpr int paddingX = 10;
constexpr int paddingY = 3;

// See https://docs.gtk.org/Pango/type_func.FontDescription.from_string.html
constexpr const char* font = "JetBrainsMonoNerdFont 11";

constexpr ColorScheme colorInactive = {Color(0xff, 0xff, 0xff), Color(0x1B, 0x1B, 0x1B)};
constexpr ColorScheme colorActive = {Color(0x1B, 0x1B, 0x1B), Color(0xFF, 0xAD, 0x00)};
constexpr const char* termcmd[] = {"foot", nullptr};

static std::vector<std::string> tagNames = {
	"󰣇", "󰈹", " ",
	"", " ",
};

constexpr Button buttons[] = {
	{ ClkStatusText,   BTN_RIGHT,  spawn,      {.v = termcmd} },
};
