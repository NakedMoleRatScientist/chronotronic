@Events = new Meteor.Collection("Events")
@Goals = new Meteor.Collection("Goals")
@GoalTemplates = new Meteor.Collection("GoalTemplate")
@Users = new Meteor.Collection("Users")
@Posts = new Meteor.Collection("Posts")
@Categories = new Meteor.Collection("Categories")

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

admin_status = () ->
  u = Meteor.user()        
  !Roles.userIsInRole(u._id,['admin'])
  
adminPermissions = {
  insert: (userId,object) ->
    return false if !Meteor.user() || admin_status()
    object.user_id == userId
  update: (userId,object) ->
    return false if !Meteor.user() || admin_status()
    object.user_id == userId
  remove: (userId,object) ->
    return false if !Meteor.user() || admin_status()
    object.user_id == userId        
}

Events.allow(genericPermission)
Goals.allow(genericPermission)
GoalTemplates.allow(genericPermission)
Categories.allow(genericPermission)
Posts.allow(adminPermissions)
Accounts.allow(adminPermissions)

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
