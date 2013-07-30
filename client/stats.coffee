Template.stats.total_hours = () ->
  seconds = 0
  events = Events.find({user_id: Meteor.userId()})
  events.forEach((e) ->
    seconds += e.seconds
  )
  (seconds / 3600).toFixed(2)


Template.stats.this_week = () ->
  get_week()
  
Template.stats.total_for_week = () ->  
  seconds = 0
  date = get_week()
  date.forEach((d) ->
    seconds += d.seconds
  )
  (seconds / 3600).toFixed(2)
    
Template.stats.size = () ->
  Events.find({user_id: Meteor.userId()}).count()

