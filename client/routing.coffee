
loggingIn = () ->
  if Meteor.loggingIn()
    this.template("loading")
    Session.set("loginState",true)
  else if Session.get("loginState") && Meteor.userId()
    Session.set("loginState",false)
    this.redirect("/dashboard")

Meteor.pages({
  '/' : {to: 'index', as: 'index'}
  '/dashboard' : 'dashboard'
  '/admin' : 'admin'
  },
  {
    defaults: { layout: 'layout', before: [loggingIn]}
  })
