Meteor.subscribe("events", () ->
  console.log("Subscription to events successful.")
)


Template.event_manager.list = () ->
  if (Session.get("events_toggl"))
    Events.find({user_id: Meteor.userId()}, {sort: {seconds: 1}})
  else
    d = Session.get("eventnav")
    start = moment().subtract("days",d).startOf("day")._d
    end = moment().subtract("days", d).endOf("end")._d
    Events.find({user_id: Meteor.userId(), date: {$gte: start, $lt: end} })


Template.event_manager.create = () ->
  Session.get("createEvent")

Template.event_manager.toggl = () ->
  Session.get("events_toggl")

Template.event_manager.is_today = () ->
  return true if Session.get("eventnav") == 0


Template.event_manager.date = () ->
  d = Session.get("eventnav")
  formatDate(moment().subtract('days', d)._d)
      
Template.event_manager.events =
  'click #delete_all' : () ->
    if Session.get("eventId") == null
      Meteor.call("removeAllEvents", (err,result) ->
        if err
          console.log(err)
      )
  'click #create' : () ->
    Session.set("createEvent",true)
  'click #previous' : () ->
    d = Session.get("eventnav")
    d += 1
    Session.set("eventnav", d)
  'click #next' : () ->
    d = Session.get("eventnav")
    d += -1
    Session.set("eventnav", d)
  'click #forward' : () ->
    d = Session.get("eventnav")
    d += 1
    Session.set("eventnav", d)
  'click #all' : () ->
    Session.set('events_toggl', true)
  'click #today' : () ->
    Session.set('events_toggl',false)