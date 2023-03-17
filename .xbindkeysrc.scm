;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start of xbindkeys guile configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This configuration is guile based.
;;   http://www.gnu.org/software/guile/guile.html
;; any functions that work in guile will work here.
;; see EXTRA FUNCTIONS:
;; This config script is supposed to live in the homedirectory.
;; Start of mouse wheel rebind at l.168

;; Version: 1.8.7

;; If you edit this file, do not forget to uncomment any lines
;; that you change.
;; The semicolon(;) symbol may be used anywhere for comments.

;; To specify a key, you can use 'xbindkeys --key' or
;; 'xbindkeys --multikey' and put one of the two lines in this file.

;; A list of keys is in /usr/include/X11/keysym.h and in
;; /usr/include/X11/keysymdef.h
;; The XK_ is not needed.

;; List of modifier:
;;   Release, Control, Shift, Mod1 (Alt), Mod2 (NumLock),
;;   Mod3 (CapsLock), Mod4, Mod5 (Scroll).


;; The release modifier is not a standard X modifier, but you can
;; use it if you want to catch release instead of press events

;; By defaults, xbindkeys does not pay attention to modifiers
;; NumLock, CapsLock and ScrollLock.
;; Uncomment the lines below if you want to use them.
;; To dissable them, call the functions with #f


;;;;EXTRA FUNCTIONS: Enable numlock, scrolllock or capslock usage
;;(set-numlock! #t)
;;(set-scrolllock! #t)
;;(set-capslock! #t)

;;;;; Scheme API reference
;;;;
;; Optional modifier state:
;; (set-numlock! #f or #t)
;; (set-scrolllock! #f or #t)
;; (set-capslock! #f or #t)
;; 
;; Shell command key:
;; (xbindkey key "foo-bar-command [args]")
;; (xbindkey '(modifier* key) "foo-bar-command [args]")
;; 
;; Scheme function key:
;; (xbindkey-function key function-name-or-lambda-function)
;; (xbindkey-function '(modifier* key) function-name-or-lambda-function)
;; 
;; Other functions:
;; (remove-xbindkey key)
;; (run-command "foo-bar-command [args]")
;; (grab-all-keys)
;; (ungrab-all-keys)
;; (remove-all-keys)
;; (debug)


;; Examples of commands:

;;(xbindkey '(control shift q) "xbindkeys_show")

;; set directly keycode (here control + f with my keyboard)
;; (xbindkey '("m:0x4" "c:41") "xterm")

;; specify a mouse button
;; (xbindkey '(control "b:2") "xterm")

;;(xbindkey '(shift mod2 alt s) "xterm -geom 50x20+20+20")

;; set directly keycode (control+alt+mod2 + f with my keyboard)
;;(xbindkey '(alt "m:4" mod2 "c:0x29") "xterm")

;; Control+Shift+a  release event starts rxvt
;;(xbindkey '(release control shift a) "rxvt")

;; Control + mouse button 2 release event starts rxvt
;;(xbindkey '(releace control "b:2") "rxvt")


;; Extra features
;; (xbindkey-function '(control a)
;;      	   (lambda ()
;;      	     (display "Hello from Scheme!")
;;      	     (newline)))

;; (xbindkey-function '(shift p)
;;      	   (lambda ()
;;      	     (run-command "xterm")))


;; Double click test
;; (xbindkey-function '(control w)
;;      	   (let ((count 0))
;;      	     (lambda ()
;;      	       (set! count (+ count 1))
;;      	       (if (> count 1)
;;      		   (begin
;;      		    (set! count 0)
;;      		    (run-command "xterm"))))))

;; Time double click test:
;;  - short double click -> run an xterm
;;  - long  double click -> run an rxvt
;; (xbindkey-function '(shift w)
;;      	   (let ((time (current-time))
;;      		 (count 0))
;;      	     (lambda ()
;;      	       (set! count (+ count 1))
;;      	       (if (> count 1)
;;      		   (begin
;;      		    (if (< (- (current-time) time) 1)
;;      			(run-command "xterm")
;;      			(run-command "rxvt"))
;;      		    (set! count 0)))
;;      	       (set! time (current-time)))))


;; Chording keys test: Start differents program if only one key is
;; pressed or another if two keys are pressed.
;; If key1 is pressed start cmd-k1
;; If key2 is pressed start cmd-k2
;; If both are pressed start cmd-k1-k2 or cmd-k2-k1 following the
;;   release order
;; (define (define-chord-keys key1 key2 cmd-k1 cmd-k2 cmd-k1-k2 cmd-k2-k1)
;;     "Define chording keys"
;;   (let ((k1 #f) (k2 #f))
;;     (xbindkey-function key1 (lambda () (set! k1 #t)))
;;     (xbindkey-function key2 (lambda () (set! k2 #t)))
;;     (xbindkey-function (cons 'release key1)
;;      	       (lambda ()
;;      		 (if (and k1 k2)
;;      		     (run-command cmd-k1-k2)
;;      		     (if k1 (run-command cmd-k1)))
;;      		 (set! k1 #f) (set! k2 #f)))
;;     (xbindkey-function (cons 'release key2)
;;      	       (lambda ()
;;      		 (if (and k1 k2)
;;      		     (run-command cmd-k2-k1)
;;      		     (if k2 (run-command cmd-k2)))
;;      		 (set! k1 #f) (set! k2 #f)))))


;; Example:
;;   Shift + b:1                   start an xterm
;;   Shift + b:3                   start an rxvt
;;   Shift + b:1 then Shift + b:3  start gv
;;   Shift + b:3 then Shift + b:1  start xpdf

;; (define-chord-keys '(shift "b:1") '(shift "b:3")
;;   "xterm" "rxvt" "gv" "xpdf")

;; Here the release order have no importance
;; (the same program is started in both case)
;; (define-chord-keys '(alt "b:1") '(alt "b:3")
;;   "gv" "xpdf" "xterm" "xterm")


;; START OF MOUS WHEEL REBIND

(define actionperformed 0)

(define (first-binding)
"First binding"
  ;; Mouse Front Shoulder Button
  (xbindkey-function '("b:9") b9-second-binding)
  ;; Mouse Rear Shoulder Button
  (xbindkey-function '("b:8") b8-second-binding)
)

(define (reset-first-binding)
"Reset first binding"
  (ungrab-all-keys)
  (remove-all-keys)
  ;; Set Action Performed state back to 0
  (set! actionperformed 0)
  ;; Forcefully release all modifier keys!
  (run-command "xdotool keyup ctrl keyup alt keyup shift keyup super&")
  (first-binding)
  (grab-all-keys)
)

(define (b8-second-binding)
"Rear Shoulder Button Extra Functions"
  (ungrab-all-keys)
  (remove-all-keys)
  ;; Scroll Up
  (xbindkey-function '("b:4")
    (lambda ()
      ;; Volume up (amixer sometimes causes left/right channels unbalance, prefere using pactl)
      ;;(run-command "amixer -D pulse sset Master 2%+")
      (run-command "pactl set-sink-volume @DEFAULT_SINK@ +2%")
      (set! actionperformed 1)
    )
  )
  ;; Scroll Down
  (xbindkey-function '("b:5")
    (lambda ()
      ;; Volume Down (amixer sometimes causes left/right channels unbalance, prefere using pactl)
      ;;(run-command "amixer -D pulse sset Master 2%-")
      (run-command "pactl set-sink-volume @DEFAULT_SINK@ -2%")
      (set! actionperformed 1)
    )
  )
  ;; Release
  (xbindkey-function '(release "b:8") 
    (lambda ()
      ;; Perform Action if Button 8 is pressed and released by itself (uncomment line below for debug)
      ;;(if (= actionperformed 0) (run-command "zenity --info --title=hi --text=Button8ReleaseEvent &"))
      (reset-first-binding)
    )
  )
  (grab-all-keys)
)

(define (b9-second-binding)
"Front Shoulder Button Extra Functions"
  (ungrab-all-keys)
  (remove-all-keys)
  ;; Scroll Up
  (xbindkey-function '("b:4")
    (lambda ()
      ;; Emulate Ctrl+Alt+Up (Workspace Up)
      ;;(run-command "xdotool keydown ctrl keydown alt key Up keyup ctrl keyup alt&")
      ;; Emulate Alt+Shift+Tab (previous window) 
      ;;(run-command "xdotool keydown alt keydown shift key Tab keyup alt keyup shift")
      ;; Emulate Control+Shift+Tab (previous tab) 
      ;;(run-command "xdotool keydown control keydown shift key Tab keyup control keyup shift")
      ;; Second (first because slower) and main screen brightness up (must install ddcutil and i2c-tools and add your user to the group i2c, then make sure to select the right bus nbr)
      ;;(run-command "ddcutil --async --bus 19 --noverify setvcp 10 + 5 && gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.gnome.SettingsDaemon.Power.Screen.StepUp")
      (set! actionperformed 1)
    )
  )
  ;; Scroll Down
  (xbindkey-function '("b:5")
    (lambda ()
      ;; Emulate Ctrl+Alt+Down (Workspace Down)
      ;;(run-command "xdotool keydown ctrl keydown alt key Down keyup ctrl keyup alt&")
      ;; Emulate Alt+Tab (next window)
      ;;(run-command "xdotool keydown alt key Tab keyup alt")
      ;; Emulate Control+Tab (next tab) 
      ;;(run-command "xdotool keydown control key Tab keyup control")
      ;; Second (first because slower) and main screen brightness down (must install ddcutil and i2c-tools and add your user to the group i2c, then make sure to select the right bus nbr)
      ;;(run-command "ddcutil --async --bus 19 --noverify setvcp 10 - 5 && gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.gnome.SettingsDaemon.Power.Screen.StepDown")
      (set! actionperformed 1)
    )
  )
  ;; Release
  (xbindkey-function '(release "b:9") 
    (lambda ()
      ;; Perform Action if Button 8 is pressed and released by itself (uncomment line below for debug)
      ;;(if (= actionperformed 0) (run-command "zenity --info --title=hi --text=Button9ReleaseEvent &"))
      (reset-first-binding)
    )
  )
  (grab-all-keys)
)

;; (debug)
(first-binding)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of xbindkeys guile configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
