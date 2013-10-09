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
