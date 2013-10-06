
Template.event_edit.selected = () ->
  return this._id

Template.event_edit.hours = () ->
  this.seconds.toTimeValue().hours
  
Template.event_edit.seconds = () ->
  this.seconds.toTimeValue().seconds

Template.event_edit.events =
  'click #destroy' : () ->
    unless Session.get("eventId") == this._id
      Events.remove({_id: this._id})
    