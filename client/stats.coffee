Template.stats.total_hours = () ->
  seconds = 0
  events = Events.find({user_id: Meteor.userId()})
  events.forEach((e) ->
    seconds += e.seconds
  )
  (seconds / 3600).toFixed(2)

hours_by_day = (n) ->
  seconds = 0
  start = moment().subtract("days", n).startOf("day")._d
  end = moment().subtract("days",n).endOf("day")._d
  events = Events.find({user_id: Meteor.userId(), date: {$gte: start, $lt: end} })
  events.forEach((e) ->
    seconds += e.seconds
  )
  (seconds / 3600).toFixed(2)

Template.stats.last_7_days = () ->
  graph = []      
  for n in [0..6]
    graph.push({date: moment().subtract("days",n).startOf("day")._d, total: hours_by_day(n)})

Template.stats.size = () ->
  Events.find({user_id: Meteor.userId()}).count()

week = () ->
  endWeek = moment().endOf("day")._d
  beginWeek = moment().subtract("days",7).startOf("day")._d
  events = Events.find({user_id: Meteor.userId(), date: {$gte: beginWeek, $lt: endWeek}})
