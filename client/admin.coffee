Template.admin.users = () ->
  Meteor.subscribe("users")
  Meteor.users.find({})

Template.admin.posts = () ->
  Meteor.posts.find({})      

Template.admin.create = () ->
  Session.get("createPost")        

Template.admin.events =
  "click #createPost": () ->
    Session.set("createPost", true)