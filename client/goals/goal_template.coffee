
Template.goal_template.seconds = () ->
  this.seconds.toString().toTime()

Template.goal_template.range = () ->
  "24 hours" if this.range == "day"

Template.goal_template.events =
  'click #destroy': () ->
    GoalTemplates.remove({_id: this._id})