Template.event.seconds = () ->
  this.seconds.toString().toTime()

Template.event.events =
  'click #destroy' : ()  ->
    unless Session.get("eventId") == this._id
      Events.remove({_id: this._id})
  'click #select' : () ->
    if Session.get("timer") == false
      Session.set("eventId",this._id)
  "click p" : () ->
    id = "name-"+ this._id
    hid = "#" + id
    name = this.name
    $(hid).replaceWith("<input id=#{id} type='text' value='" + name + "'/>").focus()
    $(hid).focus()
    $(hid).blur(() ->
      $(hid).replaceWith("<p id=#{id}>" + name + "</p>")
    )
  "keydown input" : (e) ->
    id = "name-"+ this._id
    hid = "#" + id
    if e.which == 13 && e.target.type == "text"
      Events.update(this._id, {$set: {name: $(hid).val()}})
