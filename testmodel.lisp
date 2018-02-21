;;; A simple model to test the dynamics of the retrieval buffer.
;;; It shows that spreading activation from retrieval buffer
;;; are sufficient to drive lexical effects.

(clear-all)

(define-model test-intertrial

(sgp :esc t
     :er t
     :blc 0.1
     :mas 4
     :le 0.5
     :lf 0.5
     :ga 1.0
     :retrieval-activation 10)
  
(chunk-type lexicon meaning representation order)
(chunk-type task step) 

(add-dm (quixy isa chunk)
	(xyzzy isa chunk)
	(uno isa chunk)
	(a isa lexicon meaning uno representation quixy order first)
	(b isa lexicon meaning uno representation xyzzy order second)
	(first isa chunk)
	(second isa chunk)
	(start isa chunk)
	(goal isa task step first))

(p start
   =goal>
     isa task
     step =O
   ?retrieval>
     state free
     buffer empty
==>
   +retrieval>
     isa lexicon
     order =O
     )

(p update-order
   =goal>
     isa task
     step first
   =retrieval>
     isa lexicon
     order first
==>
   *goal>
     isa task
     step second
)

(p done
   =goal>
     isa task
     step second
   =retrieval>
     isa lexicon
     order second
==>
   !stop!
)

(goal-focus goal)
  
) ; End of model
