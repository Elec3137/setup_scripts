#/bin/sh

echo 'kernel.sysrq=1' | sudo tee /etc/sysctl.d/99-reisub.conf

# nano syntax highlighting
mkdir ~/.config/nano && ls -1 /usr/share/nano/*.nanorc | sed 's/^\//include \//' > ~/.config/nano/nanorc && sudo cp ~/.config/nano/nanorc /root/.nanorc
