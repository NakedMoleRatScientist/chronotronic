Template.logout.events = () ->
  '#logout': () ->
    Meteor.logout()