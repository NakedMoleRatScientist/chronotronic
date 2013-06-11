
getUserProfile = () ->
  u = Meteor.users.findOne({_id: Meteor.userId})
  if u.profile.mode == undefined
    Meteor.users.update({_id: u.id , {$set: {"profile.mode": 0}}})
      
Template.settings.mode = () ->
  u = Meteor.user()
  if u.profile.mode == 0
    "Normal"
  else if u.profile.mode == 1
    "Pomodoro"      
        
        