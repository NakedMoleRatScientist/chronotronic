Template.category.category_name = () ->
  if this.name == null
    return "No name yet"
  this.name

Template.category.events =
  'click #destroy' : () ->
    if Events.find({name: this.name}).fetch().length == 0
      console.log("Removing")
      Categories.remove({_id: this._id})
  'click #find' : () ->
    Session.set("category",this.name)