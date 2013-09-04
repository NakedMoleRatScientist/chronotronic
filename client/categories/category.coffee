Template.category.name = () ->
  this.name()

Template.category.events =
  'click #destroy' : () ->
    if Events.find({name: this.name}).fetch().length == 0
      console.log("Removing")
      Categories.remove({_id: this._id})