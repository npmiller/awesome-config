myOthersmenu = { 
{ 'dosbox Emulator' , 'dosbox' },
{ 'Wine Windows Program Loader' , 'wine start /unix %f' },
}
myGamemenu = { 
{ 'The Elder Scrolls : Daggerfall' , 'dosbox /home/nicolas/Games/dosbox/dagger.bat' },
{ 'VBA-M' , 'gvbam' },
{ 'Lugaru' , 'lugaru' },
{ 'Minecraft' , 'minecraft' },
{ 'PlayOnLinux' , 'playonlinux' },
{ 'Pokémon Version Rouge' , 'gvbam /home/nicolas/Games/Pokemon_Rouge_Pokeblog_FR/pkmn_rouge.gbc' },
}
myGraphicsmenu = { 
{ 'GNU Image Manipulation Program' , 'gimp-2.8 %U' },
{ 'Viewnior' , 'viewnior %F' },
}
myAudioVideomenu = { 
{ 'QT V4L2 test Utility' , 'qv4l2' },
{ 'Sonata' , 'sonata' },
{ 'VLC media player' , '/usr/bin/vlc %U' },
}
myOfficemenu = { 
{ 'AbiWord' , 'abiword' },
{ 'ePDFViewer' , 'epdfview %f' },
{ 'Gnumeric' , 'gnumeric %U' },
{ 'HomeBank' , 'homebank %F' },
{ 'LibreOffice Draw' , 'libreoffice --draw %U' },
{ 'LibreOffice Impress' , 'libreoffice --impress %U' },
{ 'LibreOffice ' , 'libreoffice %U' },
{ 'Zathura' , 'zathura %f' },
}
myUtilitymenu = { 
{ 'File Manager' , 'exo-open --launch FileManager %u' },
{ 'Terminal Emulator' , 'exo-open --launch TerminalEmulator' },
{ 'Archive Manager' , 'file-roller %U' },
{ 'Vi IMproved' , 'gvim -f %F' },
{ 'LilyTerm' , 'lilyterm' },
{ 'Xarchiver' , 'xarchiver' },
{ 'About Xfce' , 'xfce4-about' },
}
myDevelopmentmenu = { 
{ 'CMake' , 'cmake-gui %f' },
{ 'Qt Assistant' , '/usr/bin/assistant' },
{ 'Qt Designer' , '/usr/bin/designer' },
{ 'Eeschema' , 'eeschema' },
{ 'FLUID' , 'fluid %F' },
{ 'OpenJDK Monitoring & Management Console' , '/usr/lib/jvm/java-6-openjdk/bin/jconsole' },
{ 'KiCad' , 'kicad' },
{ 'Qt Linguist' , '/usr/bin/linguist' },
{ 'LÖVE' , '/usr/bin/love' },
{ 'OpenJDK Policy Tool' , '/usr/lib/jvm/java-6-openjdk/bin/policytool' },
{ 'GNU Octave' , 'urxvtc -e /usr/bin/octave' },
}
myNetworkmenu = { 
{ 'Avahi SSH Server Browser' , '/usr/bin/bssh' },
{ 'Avahi VNC Server Browser' , '/usr/bin/bvnc' },
{ 'ELinks' , '/usr/bin/elinks %u' },
{ 'Mail Reader' , 'exo-open --launch MailReader %u' },
{ 'Web Browser' , 'exo-open --launch WebBrowser %u' },
{ 'Firefox' , 'firefox %u' },
{ 'Thunderbird' , 'thunderbird %u' },
{ 'XChat IRC' , 'xchat' },
{ 'Zenmap (as root)' , '/usr/share/zenmap/su-to-zenmap.sh %F' },
{ 'Zenmap' , 'zenmap %F' },
}
mySystemmenu = { 
{ 'Bulk Rename' , '/usr/lib/Thunar/ThunarBulkRename %F' },
{ 'Open Folder with Thunar' , 'thunar %F' },
{ 'Thunar File Manager' , 'thunar %F' },
{ 'Avahi Zeroconf Browser' , '/usr/bin/avahi-discover' },
{ 'dconf Editor' , 'dconf-editor' },
{ 'ettercap' , 'gksu "/usr/sbin/ettercap --gtk"' },
{ 'GParted' , 'gparted-pkexec' },
{ 'Htop' , 'urxvtc -e htop' },
{ 'urxvt (tabbed)' , 'urxvt-tabbed' },
{ 'urxvt' , 'urxvt' },
{ 'urxvt (client)' , 'urxvtc' },
{ 'UXTerm' , 'uxterm' },
{ 'Wireshark' , 'wireshark %f' },
{ 'XTerm' , 'xterm' },
}
mySettingsmenu = { 
{ 'ARandR' , 'arandr' },
{ 'Manage Printing' , '/usr/bin/xdg-open http://localhost:631/' },
{ 'Preferred Applications' , 'exo-preferred-applications' },
{ 'Adobe Flash Player' , 'flash-player-properties' },
{ 'Customize Look and Feel' , 'lxappearance' },
{ 'NVIDIA X Server Settings' , '/usr/bin/nvidia-settings' },
{ 'Qt Config ' , '/usr/bin/qtconfig' },
{ 'Printing' , 'system-config-printer' },
{ 'File Manager' , 'thunar-settings' },
{ 'Removable Drives and Media' , 'thunar-volman-settings' },
}
categoriesMenu = { 
{ 'Settings' , mySettingsmenu },
{ 'System' , mySystemmenu },
{ 'Network' , myNetworkmenu },
{ 'Development' , myDevelopmentmenu },
{ 'Utility' , myUtilitymenu },
{ 'Office' , myOfficemenu },
{ 'AudioVideo' , myAudioVideomenu },
{ 'Graphics' , myGraphicsmenu },
{ 'Game' , myGamemenu },
{ 'Others' , myOthersmenu },
{ 'Actualiser', 'lua /home/nicolas/.config/awesome/lib/menuMaker.lua'},
 }