Meteor.publish("events",
  () ->    
#    Events.find({$or:[{user_id: this.userId}]})
    e = Events.find({user_id: this.userId})
    console.log("count: " + e.count())
    e        
)

Meteor.publish("goals",
  () ->
    Goals.find({$or:[{user_id: this.userId}]})
)

Meteor.publish("goaltemplates",
  () ->
    GoalTemplates.find({$or:[{user_id: this.userId}]})
)

Meteor.publish("posts",
  () ->
    Posts.find()    
)
Meteor.publish("users", () ->
  user = Meteor.users.findOne({_id: this.userId})
  if Roles.userIsInRole(user, ["admin"])
    return Meteor.users.find({})
)

#Meteor.users.remove({username: "admin"})

user = Meteor.users.findOne({username: "admin"})
if user == undefined
  id = Accounts.createUser({username: "admin", password: "admin"})
  Roles.addUsersToRoles(id,["admin"])
