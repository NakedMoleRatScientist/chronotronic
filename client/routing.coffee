Meteor.pages({
  '/' : {to: 'index', as: 'index'}
  '/dashboard' : 'dashboard'
  '/admin' : 'admin'
  },
  {
    defaults: { layout: 'layout'}
  })

loggingIn: () ->
  if Meteor.isLoggingIn()
    this.template("loading")
    this.done()