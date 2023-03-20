|%
+$  records
  $:  watchlist=(map ship @dr)
      update-interval=@dr
  ==
+$  command
  $%  [%add-watch =ship t=@dr]
      [%del-watch =ship]
      [%set-update-interval t=@dr]
  ==
--
