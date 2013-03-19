Meteor.pages({
  '/' : {to: 'index', as: 'index'}
  '/dashboard' : 'dashboard'
  },
  {
    defaults: { layout: 'layout'}
  })
