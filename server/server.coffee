Meteor.publish("events",
  () ->
    Events.find({$or:[{user_id: this.userId}]})
)

Meteor.publish("goals",
  () ->
    Goals.find({$or:[{user_id: this.userId}]})
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

Events = new Meteor.Collection("Events")
list = Events.find({})
for e in list
  console.log("beep")
  if typeof e.date == 'string'
    Events.update(e._id,{$set: {date: new Date(e.date)}})