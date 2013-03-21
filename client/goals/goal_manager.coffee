Template.goal_manager.list = () ->
  Goals.find({user_id: Meteor.userId()})