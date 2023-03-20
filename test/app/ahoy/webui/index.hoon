/-  *ahoy, contact=contact-store
/+  ahoy, rudder, ahoy-style, sigil-svg=sigil
::
^-  (page:rudder records command)
|_  [=bowl:gall =order:rudder records]
++  argue
  |=  [headers=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder command)
  =/  args=(map @t @t)
    ?~(body ~ (frisk:rudder q.u.body))
  ?~  what=(~(get by args) 'what')  ~
  ?+    u.what  ~
      %add-watch
    ?~  who=(slaw %p (~(gut by args) 'who' ''))     ~
    ?~  when=(slaw %dr (~(gut by args) 'when' ''))  ~
    [%add-watch u.who u.when]
  ::
      %del-watch
    ?~  who=(slaw %p (~(gut by args) 'who' ''))  ~
    [%del-watch u.who]
  ==
::
++  final  (alert:rudder (cat 3 '/' dap.bowl) build)
++  build
  |=  $:  arg=(list [k=@t v=@t])
          msg=(unit [o=? =@t])
      ==
  ^-  reply:rudder
  |^  [%page page]
  ++  page
    ^-  manx
    ;html
      ;head
        ;title:"%ahoy"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
        ;style:"{(trip style:ahoy-style)}"
      ==
      ;body
        ;table
          ;tr
            ;td
              ;a/"/ahoy"
                ;h2:"%ahoy"
              ==
            ==
          ==
        ==

        ;h4:"ship monitoring (tutorial)"

        get notified if last-contact with a ship
        exceeds a specified amount of time,
        and when that ship is subsequently contacted
        
        ;+  ?~  msg  ;p:""
            ?:  o.u.msg
              ;p.green:"{(trip t.u.msg)}"
            ;p.red:"{(trip t.u.msg)}"
        ;table#ahoy
          ;form(method "post")
            ::  table header
            ;tr(style "font-weight: bold")
              ;td(align "center"):"~"
              ;td(align "center"):"@p"
              ;td(align "center"):"notify after @dr"
              ;td(align "center"):"last-contact `@dr"
            ==
            ::  first row for adding new ships
            ;tr
              ;td
                ;button(type "submit", name "what", value "add-watch"):"+"
              ==
              ;td
                ;input(type "text", name "who", placeholder "~sampel");
              ==
              ;td
                ;input(type "text", name "when", placeholder "~d1.h12.m30");
              ==
              ;td(align "center"):"~"
            ==  ::  first row
          ==    ::  form
          ;*  work
        ==
      ==  ::  body
    ==    ::  html
  ++  work
    ^-  (list manx)
    %+  turn  ~(tap by watchlist)
    |=  [=ship t=@dr]
    ;tr
      ;td
        ::  %del-watch
        ;form(method "post")
          ;button(type "submit", name "what", value "del-watch"):"-"
          ;input(type "hidden", name "who", value "{(scow %p ship)}");
        ==
        ::  ship
        ;td
          ;+  (sigil ship)
          ; {(scow %p ship)}
        ==
        ::  when to notify
        ;form(method "post")
          ;td
            ;input(type "hidden", name "what", value "add-watch");
            ;input(type "hidden", name "who", value "{(scow %p ship)}");
            ;input(type "text", name "when", value "{(scow %dr t)}");
          ==
        ==
        ::  last-contact
        ;td(align "right")
          ; {<(~(last-contact ahoy bowl) ship)>}
        ==
      ==
    ==
  ::
  ++  contacts  ~+
    =/  base=path
      /(scot %p our.bowl)/contact-store/(scot %da now.bowl)
    ?.  .^(? %gu base)  *rolodex:contact
    .^(rolodex:contact %gx (weld base /all/noun))
  ::
  ++  sigil
    |=  =ship
    ^-  manx
    =/  bg=@ux
      ?~(p=(~(get by contacts) ship) 0xff.ffff color.u.p)
    =/  fg=tape
      =+  avg=(div (roll (rip 3 bg) add) 3)
      ?:((gth avg 0xc1) "black" "white")
    =/  bg=tape
      ((x-co:co 6) bg)
    ;div.sigil(style "background-color: #{bg}; width: 20px; height: 20px;")
      ;img@"/ahoy/sigil.svg?p={(scow %p ship)}&fg={fg}&bg=%23{bg}&icon&size=20";
    ==
  --  ::  |^
--    ::  |_
