
loggingIn = () ->
  if Meteor.loggingIn() && !Meteor.UserId
    this.template("loading")
    this.stop()

Meteor.pages({
  '/' : {to: 'index', as: 'index'}
  '/dashboard' : 'dashboard'
  '/admin' : 'admin'
  },
  {
    defaults: { layout: 'layout', before: [loggingIn]}
  })
