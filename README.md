# xbindkeys-guile-mouse-altkeys-and-more

**Guile-based xbindkeys config file to setup nice shortcuts like mouse shoulder buttons + scroll wheel, alt + numpad keys, etc.**

## Set up

This configuration is guile based.

http://www.gnu.org/software/guile/guile.html

You'll need xdotool and xbindkeys with -guile support compiled for this to work (The Ubuntu xbindkeys will have this support by default).

Use `xbindkeys -dg` to generate a default .xbindkeys.scm file in your home folder, which will be used by xbindkeys, and paste the content of my .xbindkeys.scm file as you wish.

After any modification of this file, use `killall xbindkeys && xbindkeys` to reload with new bindings.

To add new bindings, you can use `xev` and `xbindkeys -k` to find what are the buttons/keys your want to bind.

## Mouse scroll wheel bindings

It assigns keybindings to the scroll wheel on the fly when mouse modifier keys are pressed. Useful for mice with lots of buttons!

Allows for example to navigate through windows, tabs or workspaces, or change master volume.

## Alt + numpad keys 

I never liked the linux solutions to type special characters (compose key and control+shift+u methods) and felt like the windowish style alt + numpad key code was faster.

The second part of this guile-based xbindkeys configuration file is an attempt to achieve this goal, and is still in progress.

## Sources

Awesome script created by Zero Angel (https://www.linuxquestions.org/questions/linux-desktop-74/%5Bxbindkeys%5D-advanced-mouse-binds-4175428297/)

Edited and further developped by Martin Genet

This couldnt have been possible without seeing Vee Lee's configuration file
