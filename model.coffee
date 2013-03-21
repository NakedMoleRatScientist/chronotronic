Events = new Meteor.Collection("Event")
Goals = new Meteor.Collection("Goals")

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
Goals.allow(
    insert: (userId,goal) ->
      return false if !Meteor.user()
      goal.user_id == userId
    update: (userId,goal) ->
      return false if !Meteor.user()
      goal.user_id == userId
    remove: (userId,event) ->
      return false if !Meteor.user()
      goal.user_id == userId
)


Meteor.methods({
    removeAllEvents: () ->
      return false if !Meteor.user()
      Events.remove({user_id: Meteor.userId()})
    count: () ->
      Meteor.users.find({}).count()
    userList: () ->
      return false if !Roles.userIsInRole(this.userId,['admin'])
      Meteor.users.find({})
  }
)
