
loggingIn = () ->
  if Meteor.loggingIn() && Session.get("loginState",2)
    this.template("loading")
    Session.set("loginState",1)
  else if Session.get("loginState") == 1 && Meteor.userId()
    Session.set("loginState",2)
    this.redirect("/dashboard")

Meteor.pages({
  '/' : {to: 'index', as: 'index'}
  '/dashboard' : 'dashboard'
  '/admin' : 'admin'
  },
  {
    defaults: { layout: 'layout', before: [loggingIn]}
  })
