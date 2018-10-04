;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HowToDesignAProgram_S01C02_Companion) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; libraries
(require 2htdp/image)
(require 2htdp/universe)
(require 2htdp/batch-io)

; ##################################
; ##      I: FIXED-SIZE DATA      ##
; ##################################

; CHAPTER 02 - FUNCTIONS AND PROGRAMS

; ## Exercise 011 ##
(define (distance-to-origin x-coord y-coord)
  (sqrt (+ (sqr x-coord) (sqr y-coord))))

; ## Exercise 012 ##
(define (cvolume side-length)
  (expt side-length 3))
(define (csurface side-length)
  (* (expt side-length 2) 6))

; ## Exercise 013 ##
(define (string-first string)
  (substring string 0 1))

; ## Exercise 014 ##
(define (string-last string)
  (substring string (- (string-length string) 1)))

; ## Exercise 015 ##
(define (==> sunny friday)
  (or (not sunny) friday))

; ## Exercise 016 ##
(define (image-area image)
  (* (image-width image) (image-width image)))

; ## Exercise 017 ##
(define (image-classify image)
  (if (> (image-width image) (image-height image))
      "wide" (if (< (image-width image) (image-height image))
          "tall" "square")))

; ## Exercise 018 ##
(define (string-join string1 string2)
  (string-append string1 "_" string2))

; ## Exercise 019 ##
(define (string-insert string i)
  (string-append (substring string 0 i) "_" (substring string i)))

; ## Exercise 020 ##
(define (string-delete string i)
  (string-append (substring string 0 i) (substring string (add1 i))))

; ## Exercise 021 ##
(define (ff a)
  (* 10 a))
(ff (ff 1))
(+ (ff 1) (ff 1))

; ## Exercise 022 ##
(distance-to-origin 3 4)

; ## Exercise 023 ##
(string-first "hello world")

; ## Exercise 024 ##
(==> #true #false)

; ## Exercise 025 ##
(define (image-classify2 img)
  (cond
    [(>= (image-height img) (image-width img)) "tall"]
    [(= (image-height img) (image-width img)) "square"]
    [(<= (image-height img) (image-width img)) "wide"]))

;(image-classify2 *insert image here before running*)

; ## Exercise 026 ##
(string-insert "helloworld" 6)

(define (letter fst lst signature-name)
  (string-append
    (opening fst)
    "\n\n"
    (body fst lst)
    "\n\n"
    (closing signature-name)))
(define (opening fst)
  (string-append "Dear " fst ","))
(define (body fst lst)
  (string-append
   "We have discovered that all people with the" "\n"
   "last name " lst " have won our lottery. So, " "\n"
   fst ", " "hurry and pick up your prize."))
(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))

; ## Exercise 027 ##
; constants
(define KNOWN-AVG-ATT 120)
(define PRICE-BASE 5.00)
(define ATT-INCREMENT 15)
(define PRICE-INCREMENT 0.10)
(define COST-FIXED 180)
(define COST-PER-ATT 0.04)
; functions
(define (attendees ticket-price)
  (- KNOWN-AVG-ATT (* (- ticket-price PRICE-BASE) (/ ATT-INCREMENT PRICE-INCREMENT))))
(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))
(define (cost ticket-price)
  (+ COST-FIXED (* COST-PER-ATT (attendees ticket-price))))
(define (profit ticket-price)
  (- (revenue ticket-price) (cost ticket-price)))

; ## Exercise 028 ##
(profit 1)
(profit 2)
(profit 3) ;this was the highest of the 5 prices from $1-$5
(profit 4)
(profit 5)
(profit 2.80)
(profit 2.90) ;this was the highest of the 5 prices from $2.80-$3.20
(profit 3.00)
(profit 3.10)
(profit 3.20)

; ## Exercise 029 ##
; constants
(define KNOWN-AVG-ATT2 120)
(define PRICE-BASE2 5.00)
(define ATT-INCREMENT2 15)
(define PRICE-INCREMENT2 0.10)
(define COST-PER-ATT2 1.50)
; functions
(define (attendees2 ticket-price)
  (- KNOWN-AVG-ATT2 (* (- ticket-price PRICE-BASE2) (/ ATT-INCREMENT2 PRICE-INCREMENT2))))
(define (revenue2 ticket-price)
  (* ticket-price (attendees2 ticket-price)))
(define (cost2 ticket-price)
  (* COST-PER-ATT2 (attendees2 ticket-price)))
(define (profit2 ticket-price)
  (- (revenue2 ticket-price) (cost2 ticket-price)))
; test
(profit2 3) 
(profit2 4)
(profit2 5)
(define (profit3 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
        (* 1.50
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price))))))
(profit3 3)
(profit3 4)
(profit3 5)

; ## Exercise 030 ##
(define PRICE-SENSITIVITY (/ ATT-INCREMENT2 PRICE-INCREMENT2))

; Interesting Note:
; "Batch" programs/scripts consume all of their inputs at once and computes a result
; "Event-driven" programs consume some of their inputs, computes, produces output,
  ; waits for more input, and so on.  Such programs use expressions to describe which functions
  ; to call for which kinds of events.  These functions are called "event-handlers".

(define (C f)
  (* 5/9 (- f 32)))
(define (convert in out)
  (write-file out
    (string-append
      (number->string
        (C
          (string->number
            (read-file in))))
      "\n")))
(write-file "sample.dat" "212")
(convert "sample.dat" 'stdout)
(convert "sample.dat" "out.dat")
(read-file "out.dat")

; ## Exercise 031 ##
(write-file 'stdout (letter "Matthew" "Fisler" "Felleisen"))
(define (main in-fst in-lst in-signature out)
  (write-file out
              (letter (read-file in-fst)
                      (read-file in-lst)
                      (read-file in-signature))))
(write-file "fst.dat" "MATTHEW")
(write-file "lst.dat" "FISLER")
(write-file "sig.dat" "FELLEISEN")
(main "fst.dat" "lst.dat" "sig.dat" "letterout.dat")
(read-file "letterout.dat")

; ## Exercise 032 ##
; Skipping this exercise because it is just a mental exercise designed to get students into the
  ; potential applications of computer programming.

(define (number->square s)
  (square s "solid" "red"))
(number->square 5)
(number->square 10)
(number->square 15)
(define (reset s ke)
  100)
(big-bang 100 [to-draw number->square])
(big-bang 100
    [to-draw number->square]
    [on-tick sub1]
    [stop-when zero?]
    [on-key reset])

(define BACKGROUND (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
(define (main2 y)
  (big-bang y
    [on-tick sub1]
    [stop-when zero?]
    [to-draw place-dot-at]
    [on-key stop]))
(define (place-dot-at y)
  (place-image DOT 50 y BACKGROUND))
(define (stop y ke)
  0)
