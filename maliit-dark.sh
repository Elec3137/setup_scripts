#!/bin/sh
# creates a bash script as /bin/maliit-keyboard to set env variables as it starts

sudo mv /bin/maliit-keyboard /bin/maliit-keyboard_og || exit
echo "
#!/bin/sh
export QT_QUICK_CONTROLS_STYLE=Universal
export QT_QUICK_CONTROLS_UNIVERSAL_THEME=Dark
/bin/maliit-keyboard_og" | sudo tee /bin/maliit-keyboard
sudo chmod +x /bin/maliit-keyboard
