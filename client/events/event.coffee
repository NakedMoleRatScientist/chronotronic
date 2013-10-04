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

  'click #edit': () ->
    console.log("beep")    

  'click #select' : () ->
    if Session.get("timer") == "start"
      Session.set("timer","resume")      
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
    id = this._id
    hid = "#" + "date-" + id
    date = this.date
    $(hid).replaceWith("<p id='dateForm-#{this._id}'><input class='input-medium' type='text' id='#{id}' name='date' value=#{formatDate(date)}><input type='button' id='dateSubmit' value='OK'><input type='button' id='dateCancel' value='Cancel'></p>")
    $(hid).datepicker({dateFormat: "yy-mm-dd"})
    $("#dateCancel").click(() ->
      $("#dateForm-#{id}").replaceWith("<p id='date-#{id}'class='date'>#{formatDate(date)}</p>")
    )
    

  "click .time" : () ->
    id =  this._id
    hid = "#" + id + '-time'
    time = this.seconds.toString().toTimeValue()
    replaceTime = this.seconds.toString().toTime()
    $(hid).replaceWith("<p id=#{id + '-time'} class='timeInput'><br /><input class='input-small' type='number' id='#{id}-hours' min='0' name='hours' value='#{time.hours}'>:<input class='input-small' type='number' id='#{id}-minutes' min='0' max='59' name='minutes' value='#{time.minutes}'>:<input class='input-small' type='number' id='#{id}-seconds' min='0' max='59' name='seconds' value='#{time.seconds}'> <input type='button' id='timeSubmit' value='OK'><br /></p>")
    $().mouseleave(() ->
      $(hid).replaceWith("<p id=#{id + '-time'} class='time'>#{replaceTime}</p>")   
    )
  "click #timeSubmit": () ->
    id = this._id  
    hid = "#" + id
    hours = $(hid + "-hours").val() * 3600
    minutes = $(hid + "-minutes").val() * 60
    seconds = $(hid + "-seconds").val() * 1
    total = hours + minutes + seconds
    Events.update(this._id, {$set: {seconds: total}})

  "click #dateSubmit": () ->
    id = "date-" + this._id
    hid = "#" + id
    date = $(hid).val()
    Events.update(this._id, {$set: {date: moment(date)._d}})   

  "keydown" : (e) ->
    if navigator.appCodeName == "Mozilla"
      hid = '#' + e.target.id
    else
      hid = '#' + e.srcElement.id
    if e.which == 13
      switch(e.target.type)
        when 'text'
          Events.update(this._id, {$set: {name: $(hid).val()}})
        when 'date'
          d = moment($(hid).val())._d
          Events.update(this._id, {$set: {date: d}})
