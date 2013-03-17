Meteor.publish("events",
  () ->
    Events.find({$or:[{user_id: this.userId}]})
)


Meteor.publish("users", () ->
  user = Meteor.users.findOne({_id: this.userId})
  if Roles.userIsInRole(user, ["admin"])
    return Meteor.users.find({}, {fields: {roles: 1}})
)

user = Meteor.users.findOne({username: "admin"})
