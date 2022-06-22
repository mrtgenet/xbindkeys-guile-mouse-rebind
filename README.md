# xbindkeys-guile-mouse-altkeys-and-more

**Guile-based xbindkeys config file to setup nice shortcuts like mouse shoulder buttons + scroll wheel, alt + numpad keys, etc.**

## Set up

This configuration is guile based.

http://www.gnu.org/software/guile/guile.html

You'll need xdotool and xbindkeys with -guile support compiled for this to work (The Ubuntu xbindkeys will have this support by default).

Use `xbindkeys --defaults-guile > ~/.xbindkeysrc.scm` to generate a default .xbindkeysrc.scm file in your home folder, which will be used by xbindkeys, and paste the content of my .xbindkeys.scm file as you wish.

After any modification of this file, use `killall xbindkeys && xbindkeys` to reload with new bindings.

To add new bindings, you can use `xev` and `xbindkeys -k` to find what are the buttons/keys your want to bind.

### ddcutil setup for external screen brightness change

If you want mouse wheel or other to change screen brightness using `ddcutil` (for example if you are using an external second screen with a laptop ; can't be monitored with `gdbus`) you will need to set things up so that you can use it without `sudo`:

1. install ddcutil

```
sudo apt install ddcutil
```

2. Manually load kernel module i2c-dev

```
modprobe i2c-dev
```

3. Verify that your monitor supports brightness control

```
sudo ddcutil capabilities | grep "Feature: 10"
```

4. udev rule for giving group i2c RW permission on the /dev/i2c devices

```
sudo cp /usr/share/ddcutil/data/45-ddcutil-i2c.rules /etc/udev/rules.d
```

5. Create i2c group and add yourself

```
sudo groupadd --system i2c

sudo usermod $USER -aG i2c
```

6. load i2c-dev automatically (needs root access)

```
touch /etc/modules-load.d/i2c.conf

echo "i2c-dev" >> /etc/modules-load.d/i2c.conf
```

7. Reboot for changes to take effect

```
sudo reboot
```

This tool uses ddcutil as backend, so first make sure that your user can use use following shell commands without root or sudo.

`ddcutil getvcp 10` to check the brightness of a monitor and

`ddcutil setvcp 10 100` to set the brightness to 100

It automatically supports multiple displays detected by `ddcutil detect`

As you might notice, `setcvp` may be quite slow.
To accelerate you might use `--async` option for multithreading and `--noverify` option once you are sure what you are doing.
The main slowing issue is the implicit call of `detect`, so you may want to note the bus number of the screen as illustrated below:

> Display 1 \
>    I2C bus:  /dev/i2c-19 <--- HERE \
>    EDID synopsis: \
>       Mfg id:               AAA \
>       Model:                AAAA P1234 \
>       Product code:         12345 \
>       Serial number:        ABCD123 \
>       Binary serial number: 123456789 (0x075bcd15) \
>       Manufacture year:     1917,  Week: 42 \
>    VCP version:         2.1 

Then specifying ``--bus 19`` will override the implicit `detect` call and speed things up.

## Mouse scroll wheel bindings

It assigns keybindings to the scroll wheel on the fly when mouse modifier keys are pressed. Useful for mice with lots of buttons!

Allows for example to navigate through windows, tabs or workspaces, or change master volume.

## Alt + numpad keys 

I never liked the linux solutions to type special characters (compose key and control+shift+u methods) and felt like the windowish style alt + numpad key code was faster.

The second part of this guile-based xbindkeys configuration file is an attempt to achieve this goal, and is still in progress.

## Known bugs

* xdotool and Coverflow Alt-Tab gnome shell extension won't work together, disabling the alt+tab mouse wheel emulator (https://github.com/dmo60/CoverflowAltTab/issues/127)

* xdotool alt+numpad key binding doesn't work with Firefox (https://stackoverflow.com/questions/65396750/xdotool-key-ignored-by-firefox-while-working-on-other-windows)

## Future developments

* Emulate the windows style alt + numpad key code (press alt, type ascii code digit by digit, release alt) instead of the 10 shortcuts.

## Sources

Awesome script created by Zero Angel (https://www.linuxquestions.org/questions/linux-desktop-74/%5Bxbindkeys%5D-advanced-mouse-binds-4175428297/)
ddcutil gnome-extension providing example use and set-up instruction by daitj (https://github.com/daitj/gnome-display-brightness-ddcutil)

Author: Martin Genet

This couldnt have been possible without seeing Vee Lee's configuration file
