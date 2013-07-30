Template.stats.total_hours = () ->
  seconds = 0
  events = Events.find({user_id: Meteor.userId()})
  events.forEach((e) ->
    seconds += e.seconds
  )
  (seconds / 3600).toFixed(2)


Template.stats.this_week = () ->
  graph = []
  begin = moment().startOf("week")
  now = moment().startOf("day")
  n = 0
  while true  
    graph.push({date: formatDate(now._d), total: hours_by_day(n).toFixed(2)})
    if now._d.toUTCString() == begin._d.toUTCString()
      break
    now.subtract("day",1).startOf("day")
    n += 1
  graph
  
Template.stats.size = () ->
  Events.find({user_id: Meteor.userId()}).count()

