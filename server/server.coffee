Meteor.publish("events",
  () ->
    Events.find({$or:[{user_id: this.userId}]})
)