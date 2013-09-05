Template.category_events.list = () ->
  Events.find({name: Session.get("category")})