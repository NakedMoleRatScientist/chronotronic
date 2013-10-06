
Template.event_edit.selected = () ->
  return this._id

Template.event_edit.hours = () ->
  this.seconds.toTimeValue().hours

Template.event_edit.minutes = () ->
  this.seconds.toTimeValue().minutes
  
Template.event_edit.seconds = () ->
  this.seconds.toTimeValue().seconds

Template.event_edit.events =
  'click #save': () ->
    hours = $("#hours-"+ this._id).val() * 3600
    minutes = $("#minutes-" + this._id).val() * 60
    seconds = $("#seconds-" + this._id).val() * 1
    total = hours + minutes + seconds
    Events.update(this._id,{$set: {seconds: total}})
    
  'click #destroy' : () ->
    unless Session.get("eventId") == this._id
      Events.remove({_id: this._id})
    