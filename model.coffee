Events = new Meteor.Collection("Events")
Goals = new Meteor.Collection("Goals")
GoalTemplates = new Meteor.Collection("GoalTemplate")
Users = new Meteor.Collection("Users")

genericPermission = {
    insert: (userId,object) ->
      return false if !Meteor.user()
      object.user_id == userId
    update: (userId,object) ->
      return false if !Meteor.user()
      object.user_id == userId
    remove: (userId,object) ->
      return false if !Meteor.user()
      object.user_id == userId
  }

Events.allow(genericPermission)
Goals.allow(genericPermission)
GoalTemplates.allow(genericPermission)


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
