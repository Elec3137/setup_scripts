#!/bin/sh
# writes fcitx5 + mozc config files
sudo pacman -S --needed --noconfirm fcitx5 fcitx5-mozc kcm-fcitx5 fcitx5-gtk

# changes in configs:
# add mozc
# "experimental" plasma theme in modules>theme
# change actiation shortcut to: ctrl+alt+space
echo 'XMODIFIERS=@im=fcitx' | sudo tee -a /etc/environment

mkdir ~/.config/fcitx5/ # in case dir is not created yet
echo '[Hotkey]
# Enumerate when press trigger key repeatedly
EnumerateWithTriggerKeys=True
# Enumerate Input Method Forward
EnumerateForwardKeys=
# Enumerate Input Method Backward
EnumerateBackwardKeys=
# Skip first input method while enumerating
EnumerateSkipFirst=False

[Hotkey/TriggerKeys]
0=Control+Alt+space
1=Zenkaku_Hankaku
2=Hangul

[Hotkey/AltTriggerKeys]
0=Shift_L

[Hotkey/EnumerateGroupForwardKeys]
0=Super+space

[Hotkey/EnumerateGroupBackwardKeys]
0=Shift+Super+space

[Hotkey/ActivateKeys]
0=Hangul_Hanja

[Hotkey/DeactivateKeys]
0=Hangul_Romaja

[Hotkey/PrevPage]
0=Up

[Hotkey/NextPage]
0=Down

[Hotkey/PrevCandidate]
0=Shift+Tab

[Hotkey/NextCandidate]
0=Tab

[Hotkey/TogglePreedit]
0=Control+Alt+P

[Behavior]
# Active By Default
ActiveByDefault=False
# Reset state on Focus In
resetStateWhenFocusIn=No
# Share Input State
ShareInputState=No
# Show preedit in application
PreeditEnabledByDefault=True
# Show Input Method Information when switch input method
ShowInputMethodInformation=True
# Show Input Method Information when changing focus
showInputMethodInformationWhenFocusIn=False
# Show compact input method information
CompactInputMethodInformation=True
# Show first input method information
ShowFirstInputMethodInformation=True
# Default page size
DefaultPageSize=5
# Override Xkb Option
OverrideXkbOption=False
# Custom Xkb Option
CustomXkbOption=
# Force Enabled Addons
EnabledAddons=
# Force Disabled Addons
DisabledAddons=
# Preload input method to be used by default
PreloadInputMethod=True
# Allow input method in the password field
AllowInputMethodForPassword=False
# Show preedit text when typing password
ShowPreeditForPassword=False
# Interval of saving user data in minutes
AutoSavePeriod=30' | tee ~/.config/fcitx5/config


echo '[Groups/0]
# Group Name
Name=Default
# Layout
Default Layout=us
# Default Input Method
DefaultIM=mozc

[Groups/0/Items/0]
# Name
Name=keyboard-us
# Layout
Layout=

[Groups/0/Items/1]
# Name
Name=mozc
# Layout
Layout=

[GroupOrder]
0=Default' | tee ~/.config/fcitx5/profile

mkdir ~/.config/fcitx5/conf/ # in case dir is not created yet
echo '# Vertical Candidate List
Vertical Candidate List=False
# Use mouse wheel to go to prev or next page
WheelForPaging=True
# Font
Font="Sans 10"
# Menu Font
MenuFont="Sans 10"
# Tray Font
TrayFont="Sans Bold 10"
# Tray Label Outline Color
TrayOutlineColor=#000000
# Tray Label Text Color
TrayTextColor=#ffffff
# Prefer Text Icon
PreferTextIcon=False
# Show Layout Name In Icon
ShowLayoutNameInIcon=True
# Use input method language to display text
UseInputMethodLanguageToDisplayText=True
# Theme
Theme=plasma
# Dark Theme
DarkTheme=plasma
# Follow system light/dark color scheme
UseDarkTheme=False
# Follow system accent color if it is supported by theme and desktop
UseAccentColor=True
# Use Per Screen DPI on X11
PerScreenDPI=False
# Force font DPI on Wayland
ForceWaylandDPI=0
# Enable fractional scale under Wayland
EnableFractionalScale=True' | tee ~/.config/fcitx5/conf/classicui.conf

echo '# Initial Mode
InitialMode=Hiragana
# Vertical candidate list
Vertical=True
# Expand Usage (Requires vertical candidate list)
ExpandMode=Always
# Fix embedded preedit cursor at the beginning of the preedit
PreeditCursorPositionAtBeginning=False
# Hotkey to expand usage
ExpandKey=Control+Alt+H' | tee ~/.config/fcitx5/conf/mozc.conf

