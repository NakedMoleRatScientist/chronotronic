createGoalIntervalEvent = (userId,goal) ->
  #1000 millisecond is one second multiplied by 3600 seconds is one hour
  #Every hour or so, we will check if we achieve our goal.
  delay = 1000 * 3600

  id = Meteor.setInterval((userId,goal) ->
    #find all events belonging to a particular user between the specified range of goal.range.
    start = moment(goal.date).startOf("day")
    end = moment(goal.date).endOf("day")
    e = Events.find({user_id: userId, date: {$gte: start, $lt: end}}).fetch()
    seconds = 0
    e.forEach((e) ->
      seconds += e.seconds
    )
    if seconds >= goal.goal
      Goals.update({_id: goal._id}, {$set: {total: seconds, reach: true}})
      Meteor.clearInterval(this)
    else
      Goals.update({_id: goal._id}, {$set: {total: seconds}})
  , delay)