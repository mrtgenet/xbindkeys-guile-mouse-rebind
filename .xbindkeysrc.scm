;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start of xbindkeys guile configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This configuration is guile based.
;; http://www.gnu.org/software/guile/guile.html
;; This config script is supposed to live in the homedirectory.
;; Awesome script created by Zero Angel (https://www.linuxquestions.org/questions/linux-desktop-74/%5Bxbindkeys%5D-advanced-mouse-binds-4175428297/)
;; Edited and further developped by Martin Genet
;; This couldnt have been possible without seeing Vee Lee's configuration file
;; You'll need xdotool and xbindkeys with -guile support compiled for this to work (The Ubuntu xbindkeys will have this support by default).
;; It assigns keybindings to the scroll wheel  on the fly when mouse modifier keys are pressed. Useful for mice with lots of buttons!
;; v1.0 -- Shoulder button + scrollwheel bindings
;; v1.1 -- Fixes some 'stuckness' problems with the modifer keys (ctrl, alt, shift)
;; v1.2 -- Can trigger events properly if the modifier button is simply pressed and released by itself. Forcefully clears modifier keys when the shoulder buttons are depressed.
;; v1.3 -- Now possible to change volume with shoulder button + scroll wheel
;; v1.4 -- No more unbalance between left and right channels after using scroll shortcut to set volume up or down
;; v1.5 -- alt key + numpad keys type special characters (windowish alternative to compose key and ctrl+shift+u methods) - IN PROGRESS

;; SECTION 1: MOUSE SCROLL AND SHOULDER BUTTONS

(define actionperformed 0)

(define (first-binding)
"First binding"
   ;; Logitech Front Shoulder Button
   (xbindkey-function '("b:9") b9-second-binding)
   ;; Logitech Rear Shoulder Button
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


(define (b9-second-binding)
"Front Shoulder Button Extra Functions"
   (ungrab-all-keys)
   (remove-all-keys)

   ;; Scroll Up
   (xbindkey-function '("b:4")
      (lambda ()
      ;; Emulate Ctrl+Alt+Up (Workspace Up)
         ;;(run-command "xdotool keydown ctrl keydown alt key Up keyup ctrl keyup alt&")
      ;; Emulate Alt+Shift+Tab (previous window) /!\ MAY NOT WORK WITH COVERFLOW ALT-TAB GNOME EXTENSION
         ;;(run-command "xdotool keydown alt keydown shift key Tab keyup alt keyup shift")
      ;; Emulate Control+Shift+Tab (previous tab) 
         (run-command "xdotool keydown control keydown shift key Tab keyup control keyup shift")
		   (set! actionperformed 1)
      )
   )

   ;; Scroll Down
   (xbindkey-function '("b:5")
      (lambda ()
      ;; Emulate Ctrl+Alt+Down (Workspace Down)
         ;;(run-command "xdotool keydown ctrl keydown alt key Down keyup ctrl keyup alt&")
      ;; Emulate Alt+Tab (next window) /!\ MAY NOT WORK WITH COVERFLOW ALT-TAB GNOME EXTENSION
         ;;(run-command "xdotool keydown alt key Tab keyup alt")
      ;; Emulate Control+Tab (next tab) 
         (run-command "xdotool keydown control key Tab keyup control")
		   (set! actionperformed 1)
      )
   )

   (xbindkey-function '(release "b:9") 
      (lambda ()
      ;; Perform Action if Button 8 is pressed and released by itself (uncomment line below for debug)
         ;;(if (= actionperformed 0) (run-command "zenity --info --title=hi --text=Button9ReleaseEvent &"))
         (reset-first-binding)
      )
   )
   
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
      )
   )

   (xbindkey-function '(release "b:8") 
      (lambda ()
      ;; Perform Action if Button 8 is pressed and released by itself (uncomment line below for debug)
         ;;(if (= actionperformed 0) (run-command "zenity --info --title=hi --text=Button8ReleaseEvent &"))
         (reset-first-binding)
      )
   )
   
   (grab-all-keys)
)
      
;; (debug)
(first-binding)

;; SECTION 2: ALT+NUMPAD SPECIAL CHARACTERS

;; Known bug: this may not work with Firefox (see https://stackoverflow.com/questions/65396750/xdotool-key-ignored-by-firefox-while-working-on-other-windows)
;; TODO: Use the real alt codes (i.e. alt+196 instead of alt+0 for '–'

;; alt+0 for – (alt+196) : U2013 // windowfocus --sync $(xdotool getactivewindow) sleep 0.125
(xbindkey '(alt KP_0) "xset r off; xdotool keyup --window 0 KP_0 key --clearmodifiers --window 0 U2013; xset r on")
;; alt+1 for « (alt+174) : U00AB
(xbindkey '(alt KP_1) "xset r off; xdotool keyup --window 0 KP_1 key --clearmodifiers --window 0 U00AB; xset r on")
;; alt+2 for ↓ (alt+25) : U2193
(xbindkey '(alt KP_2) "xset r off; xdotool keyup --window 0 KP_2 key --clearmodifiers --window 0 U2193; xset r on")
;; alt+3 for » (alt+175) : U00BB
(xbindkey '(alt KP_3) "xset r off; xdotool keyup --window 0 KP_3 key --clearmodifiers --window 0 U00BB; xset r on")
;; alt+4 for ← (alt+27) : U2190
(xbindkey '(alt KP_4) "xset r off; xdotool keyup --window 0 KP_4 key --clearmodifiers --window 0 U2190; xset r on")
;; alt+5 for À (alt+183) : U00C0
(xbindkey '(alt KP_5) "xset r off; xdotool keyup --window 0 KP_5 key --clearmodifiers --window 0 shift+U00C0; xset r on")
;; alt+6 for → (alt+26) : U2192
(xbindkey '(alt KP_6) "xset r off; xdotool keyup --window 0 KP_6 key --clearmodifiers --window 0 U2192; xset r on")
;; alt+7 for É (alt+144) : U00C9
(xbindkey '(alt KP_7) "xset r off; xdotool keyup --window 0 KP_7 key --clearmodifiers --window 0 shift+U00C9; xset r on")
;; alt+8 for ↑ (alt+24) : U2191
(xbindkey '(alt KP_8) "xset r off; xdotool keyup --window 0 KP_8 key --clearmodifiers --window 0 U2191; xset r on")
;; alt+9 for Ê (alt+210) : U00CA
(xbindkey '(alt KP_9) "xset r off; xdotool keyup --window 0 KP_9 key --clearmodifiers --window 0 shift+U00CA; xset r on")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; End of xbindkeys configuration ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
