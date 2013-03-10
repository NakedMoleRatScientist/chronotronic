Template.stats.total_hours = () ->
  seconds = 0
  for e in Events.find({user_id: Meteor.userId()})
    seconds += e.seconds
  seconds