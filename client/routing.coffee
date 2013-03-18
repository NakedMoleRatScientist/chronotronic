Meteor.Router.add({
  '/' : () ->
    if Meteor.logginIn
      Meteor.route.to("/tracker")
    else
      'index'
  '/tracker' : 'tracker'
  '/admin' : 'admin'
  })

#Copied directly from the README
Meteor.Router.filters({
  'checkLoggedIn': () ->
    if Meteor.loggingIn()
      Meteor.Router.to("/loading")
    else if Meteor.user()
      Meteor.Router.to("/tracker")
    else
      Meteor.Router.to("/")
})

Meteor.Router.filter("checkLoggedIn")