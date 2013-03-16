Template.overview.count = () ->
  Meteor.call("count", (err,result) ->
    if err
      console.log(err)
    else
      Session.set("users_count",result)
  )
  Session.get("users_count")
