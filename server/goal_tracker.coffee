intervalObjects = []

createGoalIntervalEvent = (userId,goal) ->
  #1000 millisecond is one second multiplied by 3600 seconds is one hour
  #Every hour or so, we will check if we achieve our goal.
  delay = 1000 * 3600

  id = Meteor.setInterval((userId,goal) ->
    if updateGoal(userId,goal)
      Meteor.clearInterval(this)
  , delay)
  return {tracked: goal, id}

updateGoal = (userId,goal) ->
  #find all events belonging to a particular user between the specified range of goal.range.
  events = Events.find({user_id: userId, date: {$gte: goal.start, $lt: goal.end}}).fetch()
  seconds = 0
  events.forEach((e) ->
    seconds += e.seconds
  )
  #If we meet our goal, then we update the goal as complete and clear the interval function. Otherwise, we keep updating.
  if seconds >= goal.goal
    Goals.update({_id: goal._id}, {$set: {total: seconds, reach: true}})
    return true
  else
    Goals.update({_id: goal._id}, {$set: {total: seconds}})
    false
