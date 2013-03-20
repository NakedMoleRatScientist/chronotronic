Template.admin.list = () ->
  Meteor.users.find({})

Template.admin.events =
  "click #login": () ->
    console.log("beep")