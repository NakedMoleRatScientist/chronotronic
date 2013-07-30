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
  day = moment().endOf("week").startOf("day") #Start looping at the end of the week and work backward to the beginning of this week.
  n = 0
  while true  
    graph.push({date: formatDate(day._d), total: hours_by_day(n).toFixed(2)})
    if day._d.toUTCString() == begin._d.toUTCString()
      break
    day.subtract("day",1).startOf("day")
    n += 1
  graph
  
Template.stats.size = () ->
  Events.find({user_id: Meteor.userId()}).count()

