#Create new random events.
@cnewe = (days = -1) ->
  date = moment()
  if days > 0
    date = moment().subtract("days",days)
  name = "blah" + random_num() + random_num()
  Events.insert({user_id: Meteor.userId(), seconds: (random_num() + random_num() * random_num()), pomo: 0 ,date: date._d, name: name})

#commands for the javascript console

@cdestroylast = () ->
  events = Events.find({user_id: Meteor.userId()}).fetch()
  e = Events.remove({_id: events[events.length - 1]._id})

@cpopcat = () ->
  events = Events.find({user_id: Meteor.userId()}).fetch()
  names = _.pluck(events, 'name')
  names.forEach((n) ->
    unless Categories.find({user_id: Meteor.userId(), name: n}).fetch().length > 0
      Categories.insert({user_id: Meteor.userId(), name: n, count: Events.find({user_id: Meteor.userid(), name: n}).fetch().length})
  )  