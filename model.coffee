Events = new Meteor.Collection("Events")
Goals = new Meteor.Collection("Goals")
Users = new Meteor.Collection("Users")

Events.allow(
    insert: (userId,event) ->
      return false if !Meteor.user()
      event.user_id == userId
    update: (userId,event) ->
      return false if !Meteor.user()
      event.user_id == userId
    remove: (userId,event) ->
      return false if !Meteor.user()
      event.user_id == userId
)
Goals.allow({
    update: (userId,event) ->
      event.user_id == userId
    remove: (userId,event) ->
      event.user_id == userId
  })


Meteor.methods({
    removeAllEvents: () ->
      return false if !Meteor.user()
      Events.remove({user_id: Meteor.userId()})
    count: () ->
      Meteor.users.find({}).count()
  }
)