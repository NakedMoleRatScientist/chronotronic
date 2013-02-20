Template.timer.status = () ->
  if Session.get("timer") == true
    return "stop"
  else
    return "start"

Template.timer.activated = () ->
  Session.get("timer")

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
      event = createNewEvent()
      Session.set("eventId", event)
    id = Meteor.setInterval(() ->
      Events.update(Session.get("eventId"), {$inc: {seconds: 1}})
    , 1000)

  ,'click #stop' : () ->
    Session.set("timer",false)
    Meteor.clearInterval(id)
  ,'click #finish' : () ->
    Session.set("timer",false)
    Session.set("eventId",null)
    Meteor.clearInterval(id)
