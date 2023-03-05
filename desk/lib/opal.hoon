  ::  %opal - agent wrapper for easy state peeks
::::
::    %opal detects the state of an agent and adds standard peek endpoints:
::
::      /x        for single values
::      /x/all    for all values in the state
::      /y        for lists, sets, and maps
::
::    the caller must still know the return mold of the value
::
::    %opal will only wrap "normal" molds:  atoms, lists, sets, maps, mops, mips
::
::    usage:
::
::      =*  state  -
::      %~  agent:opal  *state
::      your-agent
::
::    example:
::
::    an agent has the following state:
::
::      $:  %0
::          lang=cord
::          dict=(map cord cord)
::          locales=(set cord)
::      ==
::
::    %opal will produce the following peek endpoints and return types:
::
::      /x/state-version  term
::      /x/lang           cord
::      /x/dict/[key]     cord
::      /y/dict           (map cord cord)
::      /y/locales        (set cord)
::
::    %opal also exposes two pokes:
::
::      %opal %state      produces the agent's state
::      %opal %peeks      produces a list of current possible %opal endpoints
::
|%
++  agent
  |=  [state=mold =agent:gall]
  ^-  agent:gall
  !.
  |_  =bowl:gall
  +*  this  .
      ag    ~(. agent bowl)
      hc
  ::
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card:agent:gall agent:gall)
    ?.  ?=(%opal mark)
      =^  cards  agent  (on-poke:ag mark vase)
      [cards this]
    =/  opal
      !<(poke vase)
    =;  =tang
      ((%*(. slog pri 1) tang) [~ this])
    ?-  -.opal
      %bowl   [(sell !>(bowl))]~
    ::
        %state
      =?  grab.opal  =('' grab.opal)  '-'
      =;  product=^vase
        [(sell product)]~
      =/  state=^vase
        ::  if the underlying app has implemented a /opal/state scry endpoint,
        ::  use that vase in place of +on-save's.
        ::
        =/  result=(each ^vase tang)
          (mule |.(q:(need (need (on-peek:ag /x/opal/state)))))
        ?:(?=(%& -.result) p.result on-save:ag)
      %+  slap
        (slop state !>([bowl=bowl ..zuse]))
      (ream grab.opal)
    ::
        %incoming
      =;  =tang
        ?^  tang  tang
        [%leaf "no matching subscriptions"]~
      %+  murn
        %+  sort  ~(tap by sup.bowl)
        |=  [[* a=[=ship =path]] [* b=[=ship =path]]]
        (aor [path ship]:a [path ship]:b)
      |=  [=duct [=ship =path]]
      ^-  (unit tank)
      =;  relevant=?
        ?.  relevant  ~
        `>[path=path from=ship duct=duct]<
      ?:  ?=(~ about.opal)  &
      ?-  -.about.opal
        %ship  =(ship ship.about.opal)
        %path  ?=(^ (find path.about.opal path))
        %wire  %+  lien  duct
               |=(=wire ?=(^ (find wire.about.opal wire)))
        %term  !!
      ==
    ::
        %outgoing
      =;  =tang
        ?^  tang  tang
        [%leaf "no matching subscriptions"]~
      %+  murn
        %+  sort  ~(tap by wex.bowl)
        |=  [[[a=wire *] *] [[b=wire *] *]]
        (aor a b)
      |=  [[=wire =ship =term] [acked=? =path]]
      ^-  (unit tank)
      =;  relevant=?
        ?.  relevant  ~
        `>[wire=wire agnt=[ship term] path=path ackd=acked]<
      ?:  ?=(~ about.opal)  &
      ?-  -.about.opal
        %ship  =(ship ship.about.opal)
        %path  ?=(^ (find path.about.opal path))
        %wire  ?=(^ (find wire.about.opal wire))
        %term  =(term term.about.opal)
      ==
    ==
  ::
  ++  on-peek
    |=  =path
    ^-  (unit (unit cage))
    ::  extract state faces and values
    =/  state-values  (get-identifiers:hc -:!>(state))
    =/  state-faces   (turn state-values |=(a=[term type] -:a))
    =/  state-types   (turn state-values |=(a=[term type] +:a))

    ?+    path
        :: default fall-through
      (on-peek:ag path)
        :: %opal-specific scries
      [%u %opal ~]                 ``noun+!>(&)
      [%x %opal %state ~]          ``noun+!>(on-save:ag)
      [%x %opal %subscriptions ~]  ``noun+!>([wex sup]:bowl)
      ==
        ::
      [%x @ ~]
        :: value at top of state
      [%x @ @ ~]
        :: value inside of map, set, etc.
      [%x @ @ @ ~]
        :: value inside of mip if any
      [%x %all ~]
        :: all values
        ``noun+!>(on-save:ag)
    ==  :: top-level peek path
  ::
  ++  on-init
    ^-  (quip card:agent:gall agent:gall)
    =^  cards  agent  on-init:ag
    [cards this]
  ::
  ++  on-save   on-save:ag
  ::
  ++  on-load
    |=  old-state=vase
    ^-  (quip card:agent:gall agent:gall)
    =^  cards  agent  (on-load:ag old-state)
    [cards this]
  ::
  ++  on-watch
    |=  =path
    ^-  (quip card:agent:gall agent:gall)
    =^  cards  agent  (on-watch:ag path)
    [cards this]
  ::
  ++  on-leave
    |=  =path
    ^-  (quip card:agent:gall agent:gall)
    =^  cards  agent  (on-leave:ag path)
    [cards this]
  ::
  ++  on-agent
    |=  [=wire =sign:agent:gall]
    ^-  (quip card:agent:gall agent:gall)
    =^  cards  agent  (on-agent:ag wire sign)
    [cards this]
  ::
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card:agent:gall agent:gall)
    =^  cards  agent  (on-arvo:ag wire sign-arvo)
    [cards this]
  ::
  ++  on-fail
    |=  [=term =tang]
    ^-  (quip card:agent:gall agent:gall)
    =^  cards  agent  (on-fail:ag term tang)
    [cards this]
  --
--
::
::  this logic was extracted from language-server/complete
::
|%
++  option
  |$  [item]
  [term=cord detail=item]
++  get-identifiers
  |=  ty=type
  %-  flop
  |-  ^-  (list (option type))
  ?-    ty
      %noun      ~
      %void      ~
      [%atom *]  ~
      [%cell *]
    %+  weld
      $(ty p.ty)
    $(ty q.ty)
  ::
      [%core *]
    %-  weld
    :_  ?.  ?=(%gold r.p.q.ty)
          ~
        $(ty p.ty)
    ^-  (list (option type))
    %-  zing
    %+  turn  ~(tap by q.r.q.ty)
    |=  [term =tome]
    %+  turn
      ~(tap by q.tome)
    |=  [name=term =hoon]
    ^-  (pair term type)
    ~|  term=term
    [name ~(play ~(et ut ty) ~[name] ~)]
  ::
      [%face *]
    ?^  p.ty
      ~
    [p.ty q.ty]~
  ::
      [%fork *]
    %=    $
        ty
      =/  tines  ~(tap in p.ty)
      ?~  tines
        %void
      |-  ^-  type
      ?~  t.tines
        i.tines
      (~(fuse ut $(tines t.tines)) i.tines)
    ==
  ::
      [%hint *]  $(ty q.ty)
      [%hold *]  $(ty ~(repo ut ty))
  ==
--
