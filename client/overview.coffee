Template.overview.count = () ->
  users = 0
  Meteor.call("count", (err,result) ->
    if err
      console.log(err)
    else
      users = result
  )
  users