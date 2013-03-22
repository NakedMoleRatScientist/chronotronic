
Template.goal_template.seconds = () ->
  this.seconds.toString().toTime()

Template.goal_template.range = () ->
  "24 hours" if this.range == "day"
