Template.goal_manager.goals = () ->
  Goals.find({user_id: Meteor.userId()})

Template.goal_manager.templates = () ->
  GoalTemplates.find({user_id: Meteor.userId()})

Template.goal_manager.create = () ->
  Session.get("createGoalTemplate")

Template.goal_manager.checkActive = (name) ->
  if Session.get("goalnav") == name
    return "active"
  ""

Template.goal_manager.renderLayout = (name) ->
  Session.get("goalnav") == name

Template.goal_manager.events =
  'click #create': () ->
    Session.set("createGoalTemplate",true)
  'click #goals': () ->
    Session.set("goalnav","goals")
  'click #templates': () ->
    Session.set("goalnav","templates")