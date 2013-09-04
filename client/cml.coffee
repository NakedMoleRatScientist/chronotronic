#Create new random events.
@cnewe = (days = -1) ->
  date = moment()
  if days > 0
    date = moment().subtract("days",days)
  name = "blah" + random_num() + random_num()
  Events.insert({user_id: Meteor.userId(), seconds: (random_num() + random_num() * random_num()), pomo: 0 ,date: date._d, name: name})

#commands for the javascript console

#OUTDATED
@cinc = (s = 20) ->
  if Session.get("timer") == "stop"
    Events.update(Session.get("eventId"), {$inc: {seconds: s}})
  else
    pomoSec += s
    Events.update(Session.get("eventId"), {$inc: {pomo: s}})

#OUTDATED        
@cjump = () ->
  e = Events.findOne(Session.get("eventId"))
  if Session.get("timer") == "stop"
    jump = e.seconds + (59 - (e.seconds % 60))
    Events.update(Session.get("eventId"), {$set: {seconds: jump }})
  else
    pomoSec = 59
    jump = e.pomo + (59 - (e.pomo % 60))
    Events.update(Session.get("eventId"), {$set: {pomo: jump}})

@cdestroylast = () ->
  events = Events.find({user_id: Meteor.userId()}).fetch()
  e = Events.remove({_id: events[events.length - 1]._id})

@cpopcat = () ->
  events = Events.find({user_id: Meteor.userId()}).fetch()
  names = _pluck(events, 'name')
  names.forEach((n) ->
    unless Categories.find({user_id: Meteor.userId(), name: n}).fetch().length == 0
      Categories.insert({user_id: Meteor.userId(), name: n})
  )