Template.event.seconds = () ->
  this.seconds.toString().toTime()

Template.event.date = () ->
  formatDate(this.date)


Template.event.selected = () ->
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
    id = "time-" + this._id
    hid = "#" + id
    time = this.seconds.toString().toTimeValue()
    replaceTime = this.seconds.toString().toTime()
    $(hid).replaceWith("<p id=#{id} class='time'><input class='input-small' type='number' id='hours-#{id}' min='0' name='hours' value='#{time.hours}'>:<input class='input-small' type='number' id='minutes-#{id}' min='0' max='59' name='minutes' value='#{time.minutes}'>:<input class='input-small' type='number' id='seconds-#{id}' min='0' max='59' id='seconds' name='seconds' value='#{time.seconds}'></p>")
    $(hid).mouseleave(() ->
      $(hid).replaceWith("<p id=#{id} class='time'>#{replaceTime}</p>")   
    )


  'keydown input' : (e) ->
    hid = '#' + e.srcElement.id
    if e.watch == 13
      switch(e.target.type)
        when 'text'
          Events.update(this._id, {$set: {name: $(hid).val()}})
        when  'date'
          d = moment($(hid).val())._d
          Events.update(this._id, {$set: {date: d}})