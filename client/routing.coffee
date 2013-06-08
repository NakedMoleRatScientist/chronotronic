
loggingIn = () ->
 if Meteor.loggingIn()
    this.template("loading")

dashboardLoggedOut = () ->
  if Meteor.user() == null
    Meteor.go("/")
    this.stop()

adminLoggedOut = () ->
  if !Roles.userIsInRole(Meteor.userId(),["admin"])
    Meteor.go("/")
    this.stop()

Meteor.pages({
  '/' : {to: 'index', as: 'index'}
  '/dashboard' : {to: 'dashboard', before: [dashboardLoggedOut]}
  '/admin' : {to: 'admin', before: [adminLoggedOut]}
  '/about' : 'about'
  '/login' : 'admin_login'
  '/profile' : 'profile'
  },
  {
    defaults: { layout: 'layout', before: [loggingIn]}
  })
