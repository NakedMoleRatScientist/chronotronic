Events = new Meteor.Collection("Events")

createNewEvent = () ->
  Events.insert({user_id: Meteor.userId(), seconds: 0, date: getTodayDate()})