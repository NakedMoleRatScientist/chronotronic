Session.set("timer", "start")
Session.set("eventId", null)
Session.set("createEvent",false)
Session.set("createPost", false)
Session.set("createCategory", false)
Session.set("createGoalTemplate",false)
Session.set("mininav","events")
Session.set("users_count",0)
Session.set("events_toggl",false)
Session.set("loginState",false)
Session.set("goalnav","goals")
Session.set("eventnav", 0)
Session.set("weeknav", 0)
Session.set("category", false)

#Determine what event to edit.
Session.set("edit_event", false)

Meteor.subscribe("posts", () ->
  console.log("Subscription to posts successful")        
)