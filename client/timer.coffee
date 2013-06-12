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

id = null

checkTimer = (e) ->
  u = getUserProfile()
  return if u.mode == "Normal"
  if (e.seconds / 60) == u.activity.length
    console.log("beep")        

Template.timer.events =
  'click #start' : () ->
    if Session.get("eventId") == null && Meteor.user()
      e = Events.insert({user_id: Meteor.userId(), seconds: 0, date: new Date(), name: null})
      Session.set("eventId",e)
      Session.set("timer", "stop")
      id = Meteor.setInterval(() ->
        e = Events.update(Session.get("eventId"), {$inc: {seconds: 1}})
      , 1000)
    else if Session.get("eventId") != null && Meteor.user()
      Session.set("timer","stop")
      id = Meteor.setInterval(() ->
        Events.update(Session.get("eventId"), {$inc: {seconds: 1}})
      , 1000)
  ,'click #stop' : () ->
    Session.set("timer","start")
    Meteor.clearInterval(id)
  ,'click #finish' : () ->
    Session.set("timer","start")
    Session.set("eventId",null)
    Meteor.clearInterval(id)
