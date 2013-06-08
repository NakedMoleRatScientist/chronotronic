Template.user.username = () ->
  name = this.username
  unless name == null
    name
  else
   "No name is defined"

Template.user.roles = () ->
  console.log(this.roles)
  this.roles      