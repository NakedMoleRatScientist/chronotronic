Template.timer.status = () ->
  Session.get("timer")

Template.timer.activated = () ->
  Session.get("eventId") != null

Template.timer.event_name = () ->
  e = Events.findOne(Session.get("eventId"))
  e.name

Template.timer.event_date = () ->
  e = Events.findOne(Session.get("eventId"))
  formatDate(e.date)

Template.timer.time = () ->
  if Session.get("eventId") != null
    e = Events.findOne(Session.get("eventId"))
    return e.seconds.toString().toTime()
  "NO EVENT SELECTED"

Template.timer.pomo = () ->
  if Session.get("eventId") != null
    e = Events.findOne(Session.get("eventId"))
    return (e.pomo % 60).toString().toTime()

id = null

pomoInterval = () ->
  id = Meteor.setInterval(() ->
    e = Events.update(Session.get("eventId"), {$inc: {pomo: 1}})
    pomoTimer()
  , 1000)

activityTimer = () ->
  u = getUserProfile()
  return if u.mode == "Normal"
  e = Events.findOne({_id: Session.get("eventId")})
  if (e.seconds % (u.activitylength * 60)) == 0
    Meteor.clearInterval(id)
    Session.set("timer","pomo")

pomoTimer = () ->
  u = getUserProfile()
  e = Events.findOne({_id: Session.get("eventId")})
  if (e.seconds % (u.pomotime * 60)) == 0
    Meteor.clearInterval(id)
    Session.set("timer","stop")

activityInterval = () ->
  id = Meteor.setInterval(() ->
    e = Events.update(Session.get("eventId"), {$inc: {seconds: 1}})
    activityTimer()
  , 1000)


Template.timer.events =
  'click #start' : () ->
    if Session.get("eventId") == null && Meteor.user()
      e = Events.insert({user_id: Meteor.userId(), seconds: 0, date: new Date(), name: null})
      Session.set("eventId",e)
      Session.set("timer", "stop")
      activityInterval()
    else if Session.get("eventId") != null && Meteor.user()
      Session.set("timer","stop")
      activityInterval()
  ,'click #stop' : () ->
    Session.set("timer","start")
    Meteor.clearInterval(id)
  ,'click #finish' : () ->
    Session.set("timer","start")
    Session.set("eventId",null)
    Meteor.clearInterval(id)
