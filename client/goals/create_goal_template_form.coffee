Template.create_goal_form.events =
  'click .cancel' : () ->
    Session.set("createGoalTemplate",false)