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
