Template.stats.total_hours = () ->
  seconds = 0
  events = Events.find({user_id: Meteor.userId()})
  events.forEach((e) ->
    seconds += e.seconds
  )
  (seconds / 3600).toFixed(2)

Template.stats.today = () ->
  seconds = 0
  start = moment().startOf("day")._d
  end = moment().endOf("end")._d
  events = Events.find({user_id: Meteor.userId(), date: {$gte: start, $lt: end} })
  events.forEach((e) ->
    seconds += e.seconds
  )
  (seconds / 3600).toFixed(2)


Template.stats.size = () ->
  Events.find({user_id: Meteor.userId()}).count()
