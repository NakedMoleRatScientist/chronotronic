Template.events.size = () ->
  return Events.find({}).count();