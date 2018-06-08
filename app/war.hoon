/+  playing-cards

!:
|%
:: should probably move types into sur
++  suit  ?(%hearts %spades %clubs %diamonds)
+=  darc  [sut=suit val=@ud]
++  deck  (list darc)
+=  player-data  [opponent=@p last-darc=(unit darc) d=deck]
++  move  {bone card}
++  card  $%  $~
          ==
++  action
    $:  poker=@p
        $@(?(%play-a-card %concede) [%new-game opponent=@p])
    ==
--
::
|_  {bow/bowl:gall decks=(map @p player-data)}
++  poke-noun
    |=  a/action
    ^-  [(list move) _+>.$]
    ?-  +.a
      %play-a-card
        :: play a card
        =/  current-player-data=player-data  (~(got by decks) poker.a)
        =+  opp-darc=last-darc:(~(got by decks) opponent.current-player-data)
        =/  player-deck=deck  d.current-player-data
        =/  opp-player-data=player-data  (~(got by decks) opponent.current-player-data)
        =/  opp-deck=deck  d.opp-player-data
        ~&  "opp darc"
        ~&  opp-darc
        ?~  player-deck
            ~&  "game-over"
            [~ +>.$]
        =/  my-darc=darc  i.player-deck
        ~&  "my darc"
        ~&  my-darc
        ?~  opp-darc
            ?~  last-darc.current-player-data
                =/  new-data=player-data  current-player-data(last-darc `my-darc, d t.player-deck)
                [~ +>.$(decks (~(put by decks) poker.a new-data))]
            ~&  "waiting for opp to play"
            [~ +>.$]
        ?:  (lth val.my-darc val.u.opp-darc)
            ~&  "put-both-cards-on-bottom-of-opp-decks"
            =/  take  (take-darcs opp-player-data current-player-data `deck`~[u.opp-darc my-darc])
            [~ +>.$(decks (~(gas by decks) ~[[poker.a loser.take] [opponent.current-player-data winner.take]]))]
        ?:  (gth val.my-darc val.u.opp-darc)
            ~&  "put-both-cards-on-bottom-off-my-deck"
            =/  take  (take-darcs current-player-data opp-player-data `deck`~[u.opp-darc my-darc])
            [~ +>.$(decks (~(gas by decks) ~[[poker.a winner.take] [opponent.current-player-data loser.take]]))]
        ~&  "draw-2-cards-each-and-redo-comparison"
        =/  pool=deck  ~
        |-  ^-  [(list move) _+>.^$]
        =/  opp-split  (draw:playing-cards 2 opp-deck)
        =/  my-split   (draw:playing-cards 2 player-deck)
        =/  ipool      (weld hand.my-split (weld hand.opp-split pool))
        =/  opp-deck     rest.opp-split
        =/  player-deck  rest.my-split
        =/  my-darc      (snag (dec (lent hand.my-split)) hand.my-split)
        =/  opp-darc     (snag (dec (lent hand.opp-split)) hand.opp-split)
        ?:  (lth val.my-darc val.opp-darc)
            ~&  "put-both-cards-on-bottom-of-opp-decks"
            =/  take  (take-darcs opp-player-data current-player-data ipool)
            [~ +>.^$(decks (~(gas by decks) ~[[poker.a loser.take] [opponent.current-player-data winner.take]]))]
        ?:  (gth val.my-darc val.opp-darc)
            ~&  "put-both-cards-on-bottom-off-my-deck"
            =/  take  (take-darcs current-player-data opp-player-data ipool)
            [~ +>.^$(decks (~(gas by decks) ~[[poker.a winner.take] [opponent.current-player-data loser.take]]))]
        $(pool ipool)
      [%new-game *]
        :: make a new game
        :: this is really ugly
        :: if there is time should refactor the playing-cards lib to produce a core
        :: also need to save opponent ship as part of decks
        =+  seeda=(shax eny.bow)
        =+  seedb=(shax seeda)
        =-  [~ +>.$(decks -)]
        %-  ~(gas by decks)
        :~  :-  opponent.a
            `player-data`[poker.a ~ (shuffle-deck:playing-cards get-deck:playing-cards seeda)]
          :-  poker.a
          `player-data`[opponent.a ~ (shuffle-deck:playing-cards get-deck:playing-cards seedb)]
        ==
        :: get two shuffled decks
        :: produce a new path
      %concede
        :: end game early
        [~ +>.$]
    ==

++  take-darcs
    |=  [winner=player-data loser=player-data darc-pool=deck]
    ^-  [winner=player-data loser=player-data]
        =/  new-loser=player-data  loser(last-darc ~)
        =/  new-winner=player-data
        %=  winner
            last-darc  ~
            d          %+  weld
                           d.winner
                       darc-pool
        ==
        [new-winner new-loser]

++  prep
    |=  a=(unit *)
    `(quip move _+>.$)`[~ +>.$]
--

