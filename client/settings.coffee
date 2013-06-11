
getUserProfile = () ->
  u = Meteor.user()
  if u.profile.mode == undefined
    Meteor.users.update({_id: u._id }, {$set: {"profile.mode": 0}})
  u.profile
      
Template.settings.mode = () ->
  u = getUserProfile()
  if u.mode == 0
    "Normal"
  else if u.mode == 1
    "Pomodoro"      

Template.settings.events =
  'click #mode' : () ->
    id = "#mode"
    u = getUserProfile()
    $(id).replaceWith("<select name='mode'><option value='Normal'>Normal</option><option value='Pomodoro'>Pomodoro</option></select>")     