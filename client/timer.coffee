pomoSec = 0
transition = false
alarm = new Audio("alarmclock.wav")
resume = "normal"

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

tickPomo = () ->
  tick(pomoTick)

tickActive = () ->    
  tick(activeTick)
  
tick = (timeFunction) ->
  start = new Date()
  e = Events.findOne({_id: Session.get("eventId")})
  original = e.seconds
  id = Meteor.setInterval(() ->
    now = new Date()
    additional = (now.getTime() - start.getTime()) / 1000
    total = original + additional 
    timeFunction(total)
  , 1000)
  
pomoTick = (total) ->
  console.log("pomoTick")
  e = Events.update(Session.get("eventId"), {$set: {pomo: total}})
  pomoSec = total
  u = getUserProfile()
  e = Events.findOne({_id: Session.get("eventId")})
  if (Math.floor(pomoSec) % (u.pomotime * 60)) == 0
    transition = true
    playAlarm()

activeTick = (total) ->
  console.log("activeTick")
  e = Events.update(Session.get("eventId"), {$set: {seconds: total}})
  u = getUserProfile()
  return if u.mode == "Normal"
  e = Events.findOne({_id: Session.get("eventId")})
  if (Math.floor(e.seconds) % (u.activitylength * 60)) == 0
    transition = true
    playAlarm()

activeMode = () ->
  stopAlarm()
  transition = false
  Session.set("timer","stop")
  Meteor.clearInterval(id)
  tickActive()

pomoMode = () ->
  stopAlarm()
  transition = false
  Meteor.clearInterval(id)
  Session.set("timer","pomo")
  tickPomo()

Template.timer.events =
  'click #start' : () ->
    if Session.get("eventId") == null && Meteor.user()
      e = Events.insert({user_id: Meteor.userId(), seconds: 0, pomo: 0, date: new Date(), name: null})
      Session.set("eventId",e)
      Session.set("timer", "stop")
      tickActive()

  'click #resume' : () ->
    if resume == "normal"
      Session.set("timer","stop")
      tickActive()
    else
      Session.set("timer", "pomo")
      tickPomo()
      
  'click #rest' : () ->
    pomoMode()

  'click #work' : () ->
    activeMode()
    
  'click #skip' : () ->
    activeMode()
        
  'click #stop' : () ->
    if (Session.get("timer") == "pomo")
      resume = "pomo"
    else
      resume = "normal"  
    Session.set("timer", "resume") 
    Meteor.clearInterval(id)
    
  'click #finish' : () ->
    stopAlarm()
    pomoSec = 0
    transition = false
    Session.set("timer","start")
    Session.set("eventId",null)
    Meteor.clearInterval(id)