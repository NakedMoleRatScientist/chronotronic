Template.nav.profile = () ->
  user = Meteor.user()
  if user.profile != undefined
    name = user.profile.name
    if name != null
      return name
  "noname"

Template.nav.adminUser = () ->
  false