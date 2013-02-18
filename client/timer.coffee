Template.timer.status = () ->
  if Session.get("timer") == true
    return "stop"
  else
    return "start"

Template.timer.time = () ->
  if Session.get("eventId") != null
    e = Events.findOne(Session.get("eventId"))
    return e.seconds.toString().toTime()
  "00:00:00"

id = null

Template.timer.events =
  'click #start' : () ->
    #Start the timer and add an event
    Session.set("timer", true)
    if Session.get("eventId") == null
      event = Events.insert({user_id: Meteor.userId(), seconds: 0, date: new Date()})
      Session.set("eventId", event)
    id = Meteor.setInterval(() ->
      Events.update(Session.get("eventId"), {$inc: {seconds: 1}})
    , 1000)

  ,'click #stop' : () ->
    Session.set("timer",false)
    Meteor.clearInterval(id)
