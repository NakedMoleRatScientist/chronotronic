Template.categories.create = () ->
  Session.get("createCategory")

Template.categories.display_category = () ->
  return true if Session.get("category") != null
  false

