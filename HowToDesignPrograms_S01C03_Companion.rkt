;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HowToDesignPrograms_S01C03_Companion) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require 2htdp/batch-io)

; ##################################
; ##      I: FIXED-SIZE DATA      ##
; ##################################

; CHAPTER 03 - HOW TO DESIGN PROGRAMS

; ## Exercise 033 ##
; The "Year 2000" problem aka "Y2K" involved an issue with the way early computers programmed
  ; date-times, using only a 2-digit year (e.g. 92 for 1992).  Many people feared that date and
  ; time handling would break within critical systems (e.g. nuclear launch controls, air traffic
  ; controls, etc.) that could lead to catastrophic failures.
  ; No serious computer systems malfunctioned at 12:00am on January 1, 2000, but it is not known
  ; whether this was due to the success of collective preparations, or whether the problem was
  ; simply overblown.

; ***An example of a properly-designed function and it's accompanying definition/signature***
; Number String Image -> Image
; adds s to img, y pixels from top, 10 pixels to the left
; given: 
;    5 for y, 
;    "hello" for s, and
;    (empty-scene 100 100) for img
; expected: 
;    (place-image (text "hello" 10 "red") 10 5 ...)
;    where ... is (empty-scene 100 100)
(define (add-image y s img)
  (place-image (text s 10 "red") 10 y img))
; ***Last step in the design process after completing the above, is to test the function on your ex.***

; ## Exercise 034 ##
; String -> String
; produces a 1String from the first character of the given string
(check-expect (string-first "string") "s")
(check-expect (string-first "WORD") "W")
(define (string-first string)
  (substring string 0 1))

; ## Exercise 035 ##
; String -> String
; produces a 1String from the last character of the given string
(check-expect (string-last "string") "g")
(check-expect (string-last "thing ") " ")
(define (string-last string)
  (substring string (- (string-length string) 1)))

; ## Exercise 036 ##
; Image -> Number
; consumes an image and produces the number of pixels in that image
(check-expect (image-area (rectangle 10 10 "solid" "white")) 100)
(check-expect (image-area (circle 5 "outline" "yellow")) 100)
(define (image-area image)
  (* (image-width image) (image-width image)))

; ## Exercise 037 ##
; String -> String
; produces a string containing all the characters of the given string except for the first
(check-expect (string-rest "pants") "ants")
(check-expect (string-rest " bogs") "bogs")
(define (string-rest string)
  (substring string 1))

; ## Exercise 038 ##
; String -> String
; produces a string containing all but the last character of the given string
(check-expect (string-remove-last " weird ") " weird")
(check-expect (string-remove-last "mits") "mit")
(define (string-remove-last string)
  (substring string 0 (- (string-length string) 1)))

; Number -> Number 
; converts Fahrenheit temperatures to Celsius
; given 32, expect 0
; given 212, expect 100
; given -40, expect -40
(define (f2c f)
  (* 5/9 (- f 32)))
;(check-expect (f2c -40) -40)
;(check-expect (f2c 32) 0)
;(check-expect (f2c 212) 100)
;  The above three lines result in an 'stdout message that "All 3 tests passed!"
;  Normally can just replace the "given: , expect:" comments from the function design
;    process and replace it with the (check-expect) statements - this combines the process
;    of providing examples and testing the function into one step.

; This type of testing is called "unit testing".  One of the first tasks when switching to a new
;   programming language is to figure out that language's unit-testing framework.

; WorldState -> Image
; places the image of the car x pixels from the left margin of the BACKGROUND image
;(define (render x)
;  BACKGROUND)

; WorldState -> WorldState
; adds 3 to x to move the car right
(define (tock x)
  x)

; WorldState -> WorldState
; launches the program from some initial state
;(define (main ws)
;  (big-bang ws
;    [on-tick tock]
;    [to-draw render]))

; ## Exercise 039 ##
(define WHEEL-RADIUS 5)
(define WHEEL-COLOUR "black")
(define CAR-COLOUR "red")
(define SPACE-COLOUR "white")
(define COLOUR-MODE "solid")
(define WHEEL-DISTANCE (* WHEEL-RADIUS 4))
(define WHEEL (circle WHEEL-RADIUS COLOUR-MODE WHEEL-COLOUR))
(define WHEEL-SPACE (rectangle WHEEL-DISTANCE WHEEL-RADIUS COLOUR-MODE SPACE-COLOUR))
(define WHEELS (beside WHEEL WHEEL-SPACE WHEEL))
(define BODY-WIDTH (+ WHEEL-DISTANCE (* WHEEL-RADIUS 4)))
(define BODY-HEIGHT (* WHEEL-RADIUS 2))
(define HOOD-WIDTH (/ BODY-WIDTH 2))
(define HOOD-HEIGHT (/ BODY-HEIGHT 2))
(define BODY
  (above
    (rectangle HOOD-WIDTH HOOD-HEIGHT COLOUR-MODE CAR-COLOUR)
    (rectangle BODY-WIDTH BODY-HEIGHT COLOUR-MODE CAR-COLOUR)))




