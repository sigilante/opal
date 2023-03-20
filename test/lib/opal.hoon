  ::  %opal - agent wrapper for easy state peeks
::::
::    %opal detects the state of an agent and adds standard peek endpoints:
::
::      /x        for single values, as vase
::      /x/all    for all values in the state, as (list term)
::      /y        for lists, sets, and maps
::
::    the caller must still know the return mold of the value
::
::    %opal will only wrap "normal" molds:  atoms, lists, sets, maps, mops, mips
::
::    usage:
::
::      =|  state-0
::      =*  state  -
::      %+  agent:opal  state-0
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
  |=  [state=type =agent:gall]
  ^-  agent:gall
  !:  :: TODO !. once all works correctly
  |_  =bowl:gall
  +*  this  .
      ag    ~(. agent bowl)
  ::
  ++  on-poke    on-poke:ag
  ::
  ++  on-peek
    |=  =path
    ^-  (unit (unit cage))
    ~&  >>>  path
    ~&  >>  ?=([%u %opal *] path)
    ::  extract state faces and values
    =/  state-values  (get-identifiers rs)
    =/  state-faces   (turn state-values |=(a=[term type] -:a))
    =/  state-types   (turn state-values |=(a=[term type] +:a))
    ~&  >  state-faces
    ?+    path
        :: default fall-through
      (on-peek:ag path)
        :: %opal-specific scries
      [%x %opal %state ~]       ``noun+!>(on-save:ag)
      [%x %opal %peeks ~]       ``noun+!>(state-faces)
      [%u %opal *]              ``noun+!>(&)
        ::
      [%x @ ~]
        :: value at top of state
        ``noun+!>(on-save:ag)
      [%x @ @ ~]
        :: value inside of map, set, etc.
        ``noun+!>(on-save:ag)
      [%x @ @ @ ~]
        :: value inside of mip if any
        ``noun+!>(on-save:ag)
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
::
::  this logic was extracted from language-server/complete
::
++  option
  |$  [item]
  [term=cord detail=item]
++  get-identifiers
  |=  ty=type
  %-  flop
  |-  ^-  (list (option type))
  ?+    ty       ~
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
      ::[%hold *]  $(ty ~(repo ut ty))
  ==
--
