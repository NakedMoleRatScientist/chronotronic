
loggingIn = () ->
 if Meteor.loggingIn()
    this.template("loading")

dashboardLoggedOut = () ->
  console.log(Meteor.user())
  if Meteor.user() == null
    Meteor.go("/")
    this.stop()

Meteor.pages({
  '/' : {to: 'index', as: 'index'}
  '/dashboard' : {to: 'dashboard', before: [dashboardLoggedOut]}
  '/admin' : 'admin'
  '/about' : 'about'
  '/login' : 'admin_login'
  },
  {
    defaults: { layout: 'layout', before: [loggingIn]}
  })
