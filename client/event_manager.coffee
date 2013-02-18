Template.event_manager.size = () ->
  return Events.find({}).count()

Template.event_manager.events = () ->
  Events.find({user_id: Meteor.userId()})