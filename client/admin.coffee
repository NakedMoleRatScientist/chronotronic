Template.admin.list = () ->
  Meteor.subscribe("users")
  Meteor.users.find({})

Template.admin.events =
  "click #createPost": () ->
    console.log("beep")