#   `%opal`

![Opals of the world](https://cdn.shopify.com/s/files/1/0212/8956/6308/files/opals_of_the_world_480x480.jpg?v=1626533597)

**wip ~2023.3.20**

current status:  difficult to finish due to `agent:gall` being contravariant

i.e. you can't find the names inside of the agent state because they aren't exported

there are ways around this that I'm exploring now

https://developers.urbit.org/reference/hoon/stdlib/5c#sloe

###### wut?

`%opal` detects the state of an agent and adds standard peek endpoints:

```
  /x        for single values
  /x/all    for all values in the state
  /y        for lists, sets, and maps
```

the caller must still know the return mold of the value

`%opal` will only wrap "normal" molds:  atoms, lists, sets, maps, mops, mips; you're on your own for anything else

###### how?

import `opal` and add this line to your agent

```hoon
=|  state-0
=*  state  -
%+  agent:opal  -:!>(state-0)
your-agent
```

###### huh?

an agent has the following state:

```hoon
$:  %0
    lang=cord
    dict=(map cord cord)
    locales=(set cord)
==
```

`%opal` will produce the following peek endpoints and return types:

```hoon
/x/state-version  term
/x/lang           cord
/x/dict/[key]     cord
/y/dict           (map cord cord)
/y/locales        (set cord)
```

`%opal` also exposes two pokes:

```hoon
%opal %state      produces the agent's state
%opal %peeks      produces a list of current possible %opal endpoints
```

###### use?

parts of `%opal` can be tested with existing cores

(note that `opal` shadows an inner `hoon.hoon` type, but this shouldn't break anything for you normally)

add this line to [`%ahoy`]()

```hoon

```

and then try

```hoon
> =opal -build-file /=opal=/lib/opal/hoon

> =ahoy-ag -build-file /=ahoy=/app/ahoy/hoon

> =opal-ag (agent:opal ahoy-ag state-0:ahoy-ag)

> .^(* %gu /=ahoy=/opal/noun)

> .^(* %gx /=ahoy=/opal/state/noun)

> .^((list term) %gx /=ahoy=/opal/peeks/noun)

> .^(())

> (get-identifiers:opal -:!>(rs))
~[
  [ term='lte'
    #t/<1.fne [[a=@rs b=@rs] <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>
  ]
  [term='sea' #t/<1.viu [a=@rs <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>]
  [term='sun' #t/<1.wsi [a=@u <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>]
  [term='sig' #t/<1.nbx [a=@rs <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>]
  [ term='fma'
    #t/<1.hka [[a=@rs b=@rs c=@rs] <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>
  ]
  [ term='lth'
    #t/<1.gbn [[a=@rs b=@rs] <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>
  ]
  [term='drg' #t/<1.oiy [a=@rs <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>]
  [ term='div'
    #t/<1.znx [[a=@rs b=@rs] <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>
  ]
  [ term='grd'
      #t/
    < 1.ahy
      [ a=?([%d s=?(%.y %.n) e=@s a=@u] [%i s=?(%.y %.n)] [%n %~])
        <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>
      ]
    >
  ]
  [term='ma' #t/<24.vdk [[[w=@ud p=@ud b=@sd] r=?(%d %n %u %z)] <51.enr 137.yvb 33.sam 1.pnw %139>]>]
  [term='exp' #t/<1.fqx [a=@rs <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>]
  [ term='add'
    #t/<1.uka [[a=@rs b=@rs] <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>
  ]
  [term='toi' #t/<1.lmz [a=@rs <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>]
  [term='san' #t/<1.our [a=@s <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>]
  [term='sqt' #t/<1.fgu [a=@rs <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>]
  [ term='gth'
    #t/<1.vwo [[a=@rs b=@rs] <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>
  ]
  [ term='mul'
    #t/<1.nsx [[a=@rs b=@rs] <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>
  ]
  [ term='bit'
      #t/
    < 1.mux
      [ a=?([%f s=?(%.y %.n) e=@s a=@u] [%i s=?(%.y %.n)] [%n %~])
        <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>
      ]
    >
  ]
  [ term='equ'
    #t/<1.eoe [[a=@rs b=@rs] <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>
  ]
  [ term='gte'
    #t/<1.zqp [[a=@rs b=@rs] <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>
  ]
  [ term='sub'
    #t/<1.fuk [[a=@rs b=@rs] <21.ezj [r=?(%d %n %u %z) <51.enr 137.yvb 33.sam 1.pnw %139>]>]>
  ]
]
```
