Template.category.name = () ->
  this.name()

Template.category.count = () ->
  length = Events.find({name: this.name}).fetch().length
  console.log("beep")
  Categories.update({_id: this._id}, {$set: {count: length}})
  length

Template.category.events =
  'click #destroy' : () ->
    if Events.find({name: this.name}).fetch().length == 0
      console.log("Removing")
      Categories.remove({_id: this._id})
  'click #find' : () ->
    Session.set("category",this.name)