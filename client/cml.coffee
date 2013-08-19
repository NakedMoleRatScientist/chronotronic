#Create new random events.
@c_newe = (days = -1) ->
  date = moment()
  if days > 0
    date = moment().subtract("days",days)
  name = "blah" + random_num() + random_num()
  Events.insert({user_id: Meteor.userId(), seconds: random_num() + random_num(), pomo: 0 ,date: date._d, name: name})
  