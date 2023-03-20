::  ahoy: ship monitoring
::
::    get notified if last-contact with a ship
::    exceeds a specified amount of time,
::    and when that ship is subsequently contacted
::
::  usage:
::    :ahoy|add-watch ~sampel ~d1
::    :ahoy|del-watch ~sampel
::    :ahoy|set-update-interval ~m30
::
::  scrys:
::    .^((map @p @dr) %gx /=ahoy=/watchlist/noun)
::    .^((set ship) %gx /=ahoy=/watchlist/ships/noun)
::    .^(@dr %gx /=ahoy=/update-interval/noun)
::
/-  *ahoy, hark=hark-store
/+  default-agent, 
    agentio, 
    rudder,
    dbug,
    ahoy,
    opal
/~  pages  (page:rudder records command)  /app/ahoy/webui
::
=>  |%
    +$  card  card:agent:gall
    +$  versioned-state
      $%  state-0
      ==
    +$  state-0  [%0 records]
    --
::
=|  state-0
=*  state  -
%-  agent:dbug
%+  agent:opal  -:!>(state-0)
^-  agent:gall
=<
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
    hc    ~(. +> bowl)
    io    ~(. agentio bowl)
    pass  pass:io
::
++  on-init
  ^-  (quip card _this)
  =/  interval=@dr  ~m5
  =+  sponsor=(sein:title [our now our]:bowl)
  :_  this(update-interval interval)
  :~  (~(connect pass /eyre/connect) [~ /[dap.bowl]] dap.bowl)
      (poke-self:pass %ahoy-command !>([%add-watch sponsor ~d1]))
      (set-timer interval)
  ==
::
++  on-save  !>(state)
++  on-load
  |=  ole=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state ole)
  ?-  -.old
    %0  [~ this(state old)]
  ==
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?>  =(our src):bowl
  ?+    mark  (on-poke:def mark vase)
      %noun
    =+  !<(who=ship vase)
    :_  this
    [(send-plea:hc who)]~
  ::
      %ahoy-command
    =+  !<(cmd=command vase)
    ?-    -.cmd
        %add-watch
      =/  ss=(unit ship-state:ames)
        (~(ship-state ahoy bowl) ship.cmd)
      ?~  ss
        ~&  >>  [%ahoy '%alien ship not added']
        [~ this]
      :-  [(send-plea:hc ship.cmd)]~
      this(watchlist (~(put by watchlist) ship.cmd t.cmd))
    ::
        %del-watch
      `this(watchlist (~(del by watchlist) ship.cmd))
    ::
        %set-update-interval  
      `this(update-interval t.cmd)
    ==
  ::
      %handle-http-request
    =;  out=(quip card _+.state)
      [-.out this(+.state +.out)]
    %.  [bowl !<(order:rudder vase) +.state]
    %-  (steer:rudder _+.state command)
    :^    pages
        (point:rudder /[dap.bowl] & ~(key by pages))
      (fours:rudder +.state)
    |=  cmd=command
    ^-  $@  brief:rudder
        [brief:rudder (list card) _+.state]
    =^  cards  this
      (on-poke %ahoy-command !>(cmd))
    ['Processed succesfully.' cards +.state]
  ==
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path  (on-watch:def path)
      [%http-response *]
    ?>  =(our src):bowl
    [~ this]
  ==
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+    wire  (on-arvo:def wire sign-arvo)
      [%ahoy @ ~]  [~ this]
  ::
      [%update-interval ~]
    =^  cards  state
      on-update-interval:hc
    [cards this]
  ::
      [%eyre %connect ~]
    ?+  sign-arvo  (on-arvo:def wire sign-arvo)
        [%eyre %bound *]
      ~?  !accepted.sign-arvo
        [dap.bowl 'eyre bind rejected!' binding.sign-arvo]
      [~ this]
    ==
  ==
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?>  =(our src):bowl
  ?+  path  (on-peek:def path)
    [%x %watchlist ~]         ``noun+!>(watchlist)
    [%x %watchlist %ships ~]  ``noun+!>(~(key by watchlist))
    [%x %update-interval ~]   ``noun+!>(update-interval)
  ==
::
++  on-leave  on-leave:def
++  on-agent  on-agent:def
++  on-fail   on-fail:def
--
::
=|  cards=(list card)
|_  =bowl:gall
+*  this  .
    io    ~(. agentio bowl)
    pass  pass:io
::
++  abet
  ^-  (quip card _state)
  [(flop cards) state]
::
++  emit
  |=  car=card
  this(cards [car cards])
::
++  emil
  |=  rac=(list card)
  |-  ^+  this
  ?~  rac
    this
  =.  cards  [i.rac cards]
  $(rac t.rac)
::
++  on-update-interval
  ^-  (quip card _state)
  ::  reset timer
  =.  this  (emit (set-timer update-interval))
  ::  send pleas
  =.  this
    %-  emil
    %+  turn  ~(tap in ~(key by watchlist))
    |=  [who=ship]
    (send-plea who)
  =/  down  down-status
  ::  send notifications
  =.  this
    %-  emil
    %-  zing
    %+  turn  ~(tap in down)
    |=  [who=ship]
    (send-notification who)
  abet
::
++  set-timer
  |=  t=@dr
  ^-  card
  =/  when=@da  (add now.bowl t)
  [%pass /update-interval %arvo %b %wait when]
::  TODO check
::
++  send-plea
  |=  [who=ship]
  ^-  card
  [%pass /ahoy/(scot %p who) %arvo %a %plea who %evil-vane / ~]
::
++  down-status
  ^-  (set ship)
  %-  silt
  %+  murn  ~(tap in ~(key by watchlist))
  |=  [who=ship]
  =/  when=(unit @dr)  (~(last-contact ahoy bowl) who)
  ?~  when  ~
  ?.  (gte u.when (~(got by watchlist) who))
    ~
  `who
::
++  send-notification
  |=  [who=ship]
  ^-  (list card)
  ?.  .^(? %gu /(scot %p our.bowl)/hark-store/(scot %da now.bowl))  ~
  =/  when=@dr  (need (~(last-contact ahoy bowl) who))
  =/  title=(list content:hark)
    =-  [ship+who - ~]
    text+(crip " has not been contacted in {<when>}")
  =/  =bin:hark     [/[dap.bowl] q.byk.bowl /(scot %p who)]
  =/  =action:hark  [%add-note bin title ~ now.bowl / /ahoy]
  =/  =cage         [%hark-action !>(action)]
  [%pass /hark %agent [our.bowl %hark-store] %poke cage]~
--
