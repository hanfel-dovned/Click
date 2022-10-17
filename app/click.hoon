/-  click
/+  dbug, default-agent, server, schooner
/*  click-ui  %html  /app/click-ui/html
|%
+$  state  (map @p @ud)
+$  card  card:agent:gall
--
%-  agent:dbug
^-  agent:gall
=|  state
=*  state  -
|_  =bowl:gall
+*  this  .
    def  ~(. (default-agent this %.n) bowl)
++  on-init
  ^-  (quip card _this)
  :_  this
  ?:  =(our.bowl ~dister-hanfel-dovned)
    ~
  :~  [%pass /god %agent [~dister-hanfel-dovned %click] %watch /updates]  
    :*  %pass  /eyre/connect  %arvo  %e
        %connect  `/apps/click  %click
    ==
  ==
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  |=  =vase
  ^-  (quip card _this)
  `this(state !<(_state vase))
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^
  ?>  =(src.bowl our.bowl)
  ?+    mark
    ?>  ?!  =(src.bowl ~dister-hanfel-dovned)
    :_  this
    :~  [%give %fact ~[/incs] %noun !>(~)]  ==
    ::
      %handle-http-request
    =^  cards  state
      (handle-http !<([@ta =inbound-request:eyre] vase))
    [cards this]
  ==
  ::
  ++  handle-http
    |=  [eyre-id=@ta =inbound-request:eyre]
    ^-  (quip card _state)
    =/  ,request-line:server
      (parse-request-line:server url.request.inbound-request)
    =+  send=(cury response:schooner eyre-id)
    ?.  authenticated.inbound-request
      :_  state
      %-  send
      [302 ~ [%login-redirect './apps/click']]
    ::           
    ?+    method.request.inbound-request 
      [(send [405 ~ [%stock ~]]) state]
      ::
        %'GET'
      ?+    site  
        :_  state 
        (send [404 ~ [%plain "404 - Not Found"]])
        ::
          [%apps %click ~]
        :_  state
        (send [200 ~ [%html click-ui]])
        ::
          [%apps %click %state ~]
        :_  state
        (send [200 ~ [%json (enjs-state state)]])
      ==
      ::
        %'POST'
      :_  state
      :~  [%give %fact ~[/incs] %noun !>(~)]  ==
    ==
  ::
    ++  enjs-state
    =,  enjs:format
    |=  state=(map @p @ud)
    ^-  json
    :-  %a
    %+  turn
      ~(tap by state)
    |=  pair=[player=@p score=@ud]
    :-  %a
    :~
        (ship player:pair)
        (numb score:pair)
    ==
  --
::
++  on-peek  on-peek:def
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path  (on-watch:def path)
      [%updates ~]
    ?>  =(our.bowl ~dister-hanfel-dovned)
    :_  this
    :~  [%give %fact ~ %click-update !>(`update:click`state)]
        [%pass /prayers %agent [src.bowl %click] %watch /incs]
    ==
    ::
      [%incs ~]
    ?>  =(src.bowl ~dister-hanfel-dovned)
    `this
    ::
      [%http-response *]
    `this
  ==
::
++  on-leave  on-leave:def
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+    wire  (on-agent:def wire sign)
      [%prayers ~]
    ?+    -.sign  (on-agent:def wire sign)
        %kick
      :_  this
      :~  [%pass /prayers %agent [src.bowl %click] %watch /incs]
      ==
      ::
        %fact
      =/  oldscore  (~(get by state) src.bowl)
      =/  newscore
        ?~  oldscore
          1
        +(+.oldscore)
      =.  state  (~(put by state) src.bowl newscore)
      :_  this
      :~  [%give %fact ~[/updates] %click-update !>(`update:click`state)]
      ==
    ==
    ::
      [%god ~]
    ?+    -.sign  (on-agent:def wire sign)
        %kick
      :_  this
      :~  [%pass /god %agent [~dister-hanfel-dovned %click] %watch /updates]
      ==
      ::
        %fact
      ?+    p.cage.sign  (on-agent:def wire sign)
          %click-update
        =/  newstate  !<(update:click q.cage.sign)
        `this(state newstate)  
      ==
    ==
  == 
::
++  on-arvo  on-arvo:def
++  on-fail  on-fail:def
--