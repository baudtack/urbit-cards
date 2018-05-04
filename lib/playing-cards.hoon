!:
|%
++  suit  ?(%hearts %spades %clubs %diamonds)
+=  darc  [sut=suit val=@ud]
++  deck  (list darc)
++  get-deck
    ^-  deck
    =/  mydeck=deck  ~
    =/  i  1
    |-
    ?:  (gth i 4)
        mydeck
     =/  j  1
     |-
     ?:  (lte j 13)
         $(j +(j), mydeck [[(get-suit i) j] mydeck])
      ^$(i +(i))
++  get-suit
    |=  val=@ud
    ^-  suit
    ?+  val  !!
      %1  %hearts
      %2  %spades
      %3  %clubs
      %4  %diamonds
    ==
++  shuffle-deck
    |=  [d=deck entropy=@]
    ^-  deck
    =/  ds=deck  ~
    =+  random=~(. og entropy)
    |-
    ?:  =((lent d) 1)
        [(snag 0 d) ds]
    =+  [rnd next]=(rads:random (lent d))
    $(d (weld (scag rnd d) (slag +(rnd) d)), ds [(snag rnd d) ds], random next) 
--
