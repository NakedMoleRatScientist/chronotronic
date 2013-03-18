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
  'checkLoggedIn': (page) ->
    if Meteor.loggingIn()
      return 'loading'
    else if Meteor.user()
      return page
    else
      return 'signin'
})