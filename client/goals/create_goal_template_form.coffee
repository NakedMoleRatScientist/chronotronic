Template.create_goal_template_form.events =
  'click .cancel' : () ->
    Session.set("createGoalTemplate",false)
  'click #submit' : () ->
    #multiplying by a number coverts the value of hours, seconds, and minutes from string to integers.
    hours = $("#hours").val() * 3600
    minutes = $("#minutes").val() * 60
    seconds = $("#seconds").val() * 1
    time = hours + minutes + seconds
    GoalTemplates.insert({user_id: Meteor.userId(), seconds: time, range: "day"})