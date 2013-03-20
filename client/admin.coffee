Template.admin.list = () ->
  Meteor.users.find({})

Template.admin.events =
  "click #new_post": () ->
    console.log("beep")