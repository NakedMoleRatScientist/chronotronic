Template.event_manager.size = () ->
  return Events.find({}).count()
