
loggingIn = () ->
  if Meteor.loggingIn() && !Meteor.UserId
    this.template("loading")
    console.log("beep")
    this.stop()

Meteor.pages({
  '/' : {to: 'index', as: 'index'}
  '/dashboard' : 'dashboard'
  '/admin' : 'admin'
  },
  {
    defaults: { layout: 'layout', before: [loggingIn]}
  })
