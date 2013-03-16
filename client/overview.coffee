Template.overview.count = () ->
  Meteor.call("count", (err,result) ->
    if err
      console.log(err)
    console.log(result)
  )