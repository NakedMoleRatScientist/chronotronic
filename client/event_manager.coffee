Template.event_manager.size = () ->
  Events.find({user_id: Meteor.userId()}).count()

Template.event_manager.events = () ->
  Events.find({user_id: Meteor.userId()}, {sort: {seconds: 1}})


Template.event_manager.events =
  'click #destroy' : () ->
    Events.remove({user_id: Meteor.userId()})