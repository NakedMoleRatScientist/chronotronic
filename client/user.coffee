Template.user.username = () ->
  unless Meteor.user() == undefined
    name = Meteor.user().profile.name
    if name == null
      return "click on this to edit"
    name

    