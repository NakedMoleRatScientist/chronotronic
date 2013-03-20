
loggingIn = () ->
 if Meteor.loggingIn()
    this.template("loading")

dashboardLoggedOut = () ->
  if Meteor.user() == undefined
    this.go("/")

Meteor.pages({
  '/' : {to: 'index', as: 'index'}
  '/dashboard' : 'dashboard'
  '/admin' : 'admin'
  '/about' : 'about'
  '/login' : 'admin_login'
  },
  {
    defaults: { layout: 'layout', before: [loggingIn]}
  })
