/+  playing-cards

!:
|%
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
        :: play a card here
        ~&  (~(get by decks) ~rapfyr-diglyt)
        [~ +>.$]
      [%new-game *]
        :: make a new game
        [~ +>.$(decks (~(put by decks) opponent.a (shuffle-deck:playing-cards get-deck:playing-cards 1)))]
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
