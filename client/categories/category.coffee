Template.category.name = () ->
  this.name()

Template.event.events =
  'click #destroy' : () ->
    Categories.remove({_id: this._id})