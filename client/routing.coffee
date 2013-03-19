
loggingIn = () ->
  if Meteor.loggingIn()
    this.template("loading")


Meteor.pages({
  '/' : {to: 'index', as: 'index'}
  '/dashboard' : 'dashboard'
  '/admin' : 'admin'
  },
  {
    defaults: { layout: 'layout', before: [loggingIn]}
  })
