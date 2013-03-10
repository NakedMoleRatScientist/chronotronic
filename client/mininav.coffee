Template.mininav.checkActive = (name) ->
  if Session.get("mininav") == name
    return "active"
  ""