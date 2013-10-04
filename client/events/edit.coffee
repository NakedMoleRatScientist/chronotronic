
Template.event_edit.selected = () ->
  return this._id

Template.event_edit.events =
  'click #destroy' : () ->
    unless Session.get("eventId") == this._id
      Events.remove({_id: this._id})
    