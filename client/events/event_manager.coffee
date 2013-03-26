Meteor.subscribe("events", () ->
  console.log("Subscription to events successful.")
)


Template.event_manager.list = () ->
  if (Session.get("events_toggl"))
    Events.find({user_id: Meteor.userId()}, {sort: {seconds: 1}})
  else
    start = moment().startOf("day")._d
    end = moment().endOf("end")._d
    Events.find({user_id: Meteor.userId(), date: {$gte: start, $lt: end} })


Template.event_manager.create = () ->
  Session.get("createEvent")

Template.event_manager.toggl = () ->
  Session.get("events_toggl")


Template.event_manager.events =
  'click #delete_all' : () ->
    if Session.get("eventId") == null
      Meteor.call("removeAllEvents", (err,result) ->
        if err
          console.log(err)
      )
  'click #create' : () ->
    Session.set("createEvent",true)
  'click #all' : () ->
    Session.set('events_toggl', true)
  'click #today' : () ->
    Session.set('events_toggl',false)