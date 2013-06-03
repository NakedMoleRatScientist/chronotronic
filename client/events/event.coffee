Template.event.seconds = () ->
  this.seconds.toString().toTime()

Template.event.date = () ->
  formatDate(this.date)


Template.event.status = () ->
  if Session.get("eventId") == this._id
    return "info"
  return null

Template.event.events =
  'click #destroy' : ()  ->
    unless Session.get("eventId") == this._id
      Events.remove({_id: this._id})

  'click #select' : () ->
    if Session.get("timer") == false
      Session.set("eventId",this._id)

  "click .name" : () ->
    id = "name-"+ this._id
    hid = "#" + id
    name = this.name
    $(hid).replaceWith("<input id=#{id} type='text' value='" + name + "'/>")
    $(hid).focus()
    $(hid).blur(() ->
      $(hid).replaceWith("<p id=#{id} class='name'>" + name + "</p>")
    )

  "click .date" : () ->
    id = "date-" + this._id
    hid = "#" + id
    date = this.date
    console.log(date)
    $(hid).replaceWith("<input class='input-medium' type='date' id='#{id}' name='date' value=#{formatDate(date)}>")
    $(hid).focus()
    $(hid).blur(() ->
      $(hid).replaceWith("<p id=#{id} class='date'>#{formatDate(date)}</p>")
    )

  "click .time" : () ->
    $(hid).replaceWith("<input class='input-small' type='number' id='hours' min='0' name='hours' value='0'>:<input class='input-small' type='number' id='minutes' min='0' max='59' name='minutes' value='0'>:<input class='input-small' type='numbe id='seconds' min='0' max='59' id='seconds' name='seconds' value='0'>")

  'keydown input' : (e) ->
    hid = '#' + e.srcElement.id
    if e.which == 13 && e.target.type == 'text'
      console.log("beep")  
      Events.update(this._id, {$set: {name: $(hid).val()}})
    else if e.which == 13 && e.target.type == 'date'
      Events.update(this._id, {$set: {date: new Date($(hid).val())}})