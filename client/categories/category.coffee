Template.category.name = () ->
  this.name()

Template.category.events =
  'click #destroy' : () ->
    Categories.remove({_id: this._id})