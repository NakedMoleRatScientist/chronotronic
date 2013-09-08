Template.category.name = () ->
  console.log("deep")
  this.name

Template.category.count = () ->
  this.count
  

Template.category.events =
  'click #destroy' : () ->
    if Events.find({name: this.name}).fetch().length == 0
      console.log("Removing")
      Categories.remove({_id: this._id})
  'click #find' : () ->
    Session.set("category",this.name)