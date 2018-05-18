/+  playing-cards

!:
|%
:: should probably move types into sur
++  suit  ?(%hearts %spades %clubs %diamonds)
+=  darc  [sut=suit val=@ud]
++  deck  (list darc)
++  move  {bone card}
++  card  $%  $~        
          ==
++  action
    $@(?(%play-a-card %concede) [%new-game opponent=@p])
--
::
|_  {bow/bowl:gall decks=(map @p deck)}
++  poke-noun
    |=  a/action
    ^-  [(list move) _+>.$]
    ?-  a
      %play-a-card
        :: play a card
        :: grab top card
        :: set aside
        :: if opponent has played
        ::   compare cards
        ::   both cards go on the bottom of deck of player with highercard
        ::   if cards equal rank
        ::     deal two from each deck and compare
        ::   winner takes all cards
        :: game over when one player has all cards.
        ~&  (~(get by decks) src.bow)
        [~ +>.$]
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
            (shuffle-deck:playing-cards get-deck:playing-cards seeda)
          :-  src.bow
          (shuffle-deck:playing-cards get-deck:playing-cards seedb)
        ==
        :: get two shuffled decks
        :: produce a new path
      %concede
        :: end game early
        [~ +>.$]
    ==
--


:: create a second app as a client
:: subscribe to this app
:: take pokes and print gamestate to console
