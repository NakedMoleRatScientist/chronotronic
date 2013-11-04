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

#anonymous user profile
@profile = {pomotime: 10, activitylength: 60, mode: "Normal"}

#weekNav for navigating event history by weeks
Session.set("weeknav", 0)

#category ID for selected category
Session.set("category", false)

#random ID for a non-logged in user.
Session.set("anon_id",Random.id())

#Determine what event to edit.
Session.set("edit_event", false)

Meteor.subscribe("posts", () ->
  console.log("Subscription to posts successful")        
)
@One = new Meteor.Collection("Events")
@Two = new Meteor.Collection(null)
  
Deps.autorun(() =>
  user = Meteor.userId()
  if user != null
    @Events = @One
  else if user == null
    console.log("beep")
    @Events = @Two
)