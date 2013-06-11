
getUserProfile = () ->
  u = Meteor.user()
  if u.profile.mode == undefined
    Meteor.users.update({_id: u._id }, {$set: {"profile.mode": 0}})
  u.profile

decideMode = (mode) ->
  if mode == 0
    "Normal"
  else if mode == 1
    "Pomodoro"

Template.settings.mode = () ->
  u = getUserProfile()
  decideMode(u.mode)

Template.settings.events =
  'click #mode' : () ->
    id = "#mode"
    u = getUserProfile()
    $(id).replaceWith("<dd id='mode'><select name='mode'><option value='Normal'>Normal</option><option value='Pomodoro'>Pomodoro</option></select></dd>")
    $(id).focus()
    $(id).blur(() ->
        $(id).replaceWith("<dd id='mode'>#{decideMode(u.mode)}</dd>")
    )