Events = new Meteor.Collection("Events")

Events.allow({
    insert: () ->
     false
  })

Meteor.methods({
    createNewEvent: () ->
      Events.insert({user_id: Meteor.userId(), seconds: 0, date: getTodayDate()})
  }
)