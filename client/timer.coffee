pomoSec = 0
transition = false
alarm = new Audio("alarmclock.mp3")

playAlarm = () ->
  alarm.play()

stopAlarm = () ->
  alarm.pause()
  alarm.currentTime = 0

Template.timer.status = () ->
  Session.get("timer")

Template.timer.transition = () ->
  transition

Template.timer.checkButton = (name) ->
  if Session.get("timer") == name
    return true
  false  

Template.timer.activated = () ->
  Session.get("eventId") != null

Template.timer.event_name = () ->
  e = Events.findOne(Session.get("eventId"))
  e.name

Template.timer.event_date = () ->
  e = Events.findOne(Session.get("eventId"))
  formatDate(e.date)

Template.timer.timer = () ->
  if Session.get("eventId") != null
    e = Events.findOne(Session.get("eventId"))
    if Session.get("timer") != "pomo"
      result = e.seconds.toString().toTime()
      return result
    else
      result = (pomoSec).toString().toTime()
      return result
   "NO EVENT SELECTED"

id = null

pomoInterval = () ->
  id = Meteor.setInterval(() ->
    console.log("pomo")
    e = Events.update(Session.get("eventId"), {$inc: {pomo: 1}})
    pomoSec += 1
    pomoTimer()
  , 1000)

activityInterval = () ->
  id = Meteor.setInterval(() ->
    console.log("active")
    e = Events.update(Session.get("eventId"), {$inc: {seconds: 1}})
    activityTimer()
  , 1000)

activeMode = () ->
  transition = false
  Session.set("timer","stop")
  Meteor.clearInterval(id)
  activityInterval()

pomoMode = () ->
  transition = false
  Meteor.clearInterval(id)
  Session.set("timer","pomo")
  pomoInterval()

activityTimer = () ->
  u = getUserProfile()
  return if u.mode == "Normal"
  e = Events.findOne({_id: Session.get("eventId")})
  if (e.seconds % (u.activitylength * 60)) == 0
    transition = true
    playAlarm()
    
pomoTimer = () ->
  u = getUserProfile()
  e = Events.findOne({_id: Session.get("eventId")})
  if (pomoSec % (u.pomotime * 60)) == 0
    transition = true
    playAlarm()

Template.timer.events =
  'click #start' : () ->
    if Session.get("eventId") == null && Meteor.user()
      e = Events.insert({user_id: Meteor.userId(), seconds: 0, pomo: 0, date: new Date(), name: null})
      Session.set("eventId",e)
      Session.set("timer", "stop")
      activityInterval()
    else if Session.get("eventId") != null && Meteor.user()
      Session.set("timer","stop")
      activityInterval()

  'click #rest' : () ->
    pomoMode()

  'click #work' : () ->
    activeMode()
    
  'click #skip' : () ->
    activeMode()
        
  'click #stop' : () ->
    Session.set("timer","start")
    Meteor.clearInterval(id)
    
  'click #finish' : () ->
    Session.set("timer","start")
    Session.set("eventId",null)
    Meteor.clearInterval(id)

#commands for the javascript console

this.inc = (s = 20) ->
  if Session.get("timer") == "stop"
    Events.update(Session.get("eventId"), {$inc: {seconds: s}})
  else
    pomoSec += s
    Events.update(Session.get("eventId"), {$inc: {pomo: s}})
    
this.jump = () ->
  e = Events.findOne(Session.get("eventId"))
  if Session.get("timer") == "stop"
    jump = e.seconds + (59 - (e.seconds % 60))
    Events.update(Session.get("eventId"), {$set: {seconds: jump }})
  else
    pomoSec = 59
    jump = e.pomo + (59 - (e.pomo % 60))
    Events.update(Session.get("eventId"), {$set: {pomo: jump}})  