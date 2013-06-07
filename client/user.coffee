Template.user.username = () ->
  unless Meteor.user() == undefined
    name = Meteor.user().profile.name
    if name == null
      return "click on this to edit"
    name

Template.user.events =
  'click #name' : () ->
     id = "#name"
     name = Meteor.user().profile.name
     $(id).replaceWith("<input id='name' type='text' value='#{name}'/>")
     $(id).focus()
     $(id).blur(() ->
       $(id).replaceWith("<dd id='name'>#{Template.user.username()}</dd>")
     )
