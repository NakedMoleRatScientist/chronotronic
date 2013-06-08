Template.user.username = () ->
  name = this.username
  unless name == null
    name
  else
   "No name is defined"

Template.user.roles = () ->
  r = ""
  unless this.roles == undefined
    for i in this.roles
      r += i      