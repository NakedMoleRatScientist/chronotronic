Template.create_category_form.events =
  "click #cancel": () ->
    Session.set("createCategory",false)
  "click #create": () ->
    name = $("#category").val()
    