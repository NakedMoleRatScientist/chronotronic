Template.category_events.list = () ->
  Events.find({name: Session.get("category")})

Template.category_events.name = () ->
  Session.get("category")