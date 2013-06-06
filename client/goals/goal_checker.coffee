goalChecker = () ->
  list = GoalTemplates.find({user_id: Meteor.userId()})
  for g in list
    Goals.find({user_id: Meteor.userId(), template: g._id})           