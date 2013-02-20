Template.event.seconds = () ->
  this.seconds.toString().toTime()

Template.event.events =
  'click #destroy' : ()  ->
    Events.remove({_id: this._id})
