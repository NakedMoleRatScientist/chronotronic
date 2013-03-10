Template.stats.total_hours = () ->
  seconds = 0
  events = Events.find({user_id: Meteor.userId()})
  console.log(events.count())
  events.forEach((e) ->
    seconds += e.seconds
  )
  (seconds / 3600).toFixed(2)

pastSevenDaysEvents = () ->
  findList = previousDays(6)
  events = []
  for f in findList
    events += Events.find({user_id: Meteor.userId(), date: f})
  events