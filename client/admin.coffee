Template.admin.list = () ->
  Meteor.subscribe("users")
  Meteor.users.find({})

Template.admin.events =
  "click #new_post": () ->
    console.log("beep")