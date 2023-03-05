#   `%opal`

%opal detects the state of an agent and adds standard peek endpoints:

```
  /x        for single values
  /x/all    for all values in the state
  /y        for lists, sets, and maps
```

the caller must still know the return mold of the value

%opal will only wrap "normal" molds:  atoms, lists, sets, maps, mops, mips

usage:

```
  =*  state  -
  %~  agent:opal  *state
  your-agent
```

example:

an agent has the following state:

```
  $:  %0
      lang=cord
      dict=(map cord cord)
      locales=(set cord)
  ==
```

%opal will produce the following peek endpoints and return types:

```
  /x/state-version  term
  /x/lang           cord
  /x/dict/[key]     cord
  /y/dict           (map cord cord)
  /y/locales        (set cord)
```

%opal also exposes two pokes:

```
  %opal %state      produces the agent's state
  %opal %peeks      produces a list of current possible %opal endpoints
```
