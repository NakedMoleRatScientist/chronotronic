Template.categories.create = () ->
  Session.get("createCategory")

Template.categories.events =
  "click #create": () ->
    Session.set("createCategory",true)  