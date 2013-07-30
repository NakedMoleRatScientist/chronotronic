Template.stats.total_hours = () ->
  seconds = 0
  events = Events.find({user_id: Meteor.userId()})
  events.forEach((e) ->
    seconds += e.seconds
  )
  (seconds / 3600).toFixed(2)


Template.stats.last_7_days = () ->
  graph = []
   
  for n in [0..6]
    graph.push({date: formatDate(moment().subtract("days",n).startOf("day")._d), total: hours_by_day(n).toFixed(2)})
  graph


Template.stats.size = () ->
  Events.find({user_id: Meteor.userId()}).count()

