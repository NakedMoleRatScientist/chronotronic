Template.event.seconds = () ->
  this.seconds.toString().toTime()

Template.event.date = () ->
  formatDate(this.date)


Template.event.selected = () ->
  if Session.get("eventId") == this._id
    return "info"
  return null

Template.event.events =
  'click #select' : () ->
    if Session.get("timer") == "start"
      Session.set("timer","resume")      
      Session.set("eventId",this._id)
  'click #edit' : () ->
    Session.set("edit_event",this._id)