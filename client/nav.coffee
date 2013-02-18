Template.nav.profile = () ->
  user = Meteor.user()
  if user.name != null
    return name
  else
    return "noname"