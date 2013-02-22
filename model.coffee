Events = new Meteor.Collection("Events")

Events.allow({
    insert: () ->
     false
    ,
    remove: (userId,events) ->
       ! _.any(events, (event) -> return event.id == userId)
    update: (userId,events) ->
       ! _.any(events, (event) -> return event.id == userId)


  })

Meteor.methods({
    createNewEvent: () ->
      Events.insert({user_id: Meteor.userId(), seconds: 0, date: getTodayDate(), name: null})
  }
)