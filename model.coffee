Events = new Meteor.Collection("Events")

Events.allow({
    update: (userId,event) ->
      event.user_id == userId
    remove: (userId,event) ->
      event.user_id == userId
  })

Meteor.methods({
    createTimerEvent: () ->
      Events.insert({user_id: Meteor.userId(), seconds: 0, date: getTodayDate(), name: null})
    createNewEvent: (date,name,time) ->
      Events.insert({user_id: Meteor.userId(), seconds: time, date: date, name: name})
    removeAll: () ->
      Events.remove({user_id: Meteor.userId()})
  }
)