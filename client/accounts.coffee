import {Accounts} from 'meteor/accounts-base'

Accounts.ui.config
  passwordSignupFields:
    if Meteor.settings.public.coauthor?.emailless
      'USERNAME_ONLY'
    else
      'USERNAME_AND_EMAIL'
  extraSignupFields: [
    fieldName: 'fullname'
    fieldLabel: 'Full name (FirstName LastName)'
    inputType: 'text'
  ]

Template._loginButtonsAdditionalLoggedInDropdownActions.helpers # eslint-disable-line meteor/template-names
  unverified: ->
    _.some Meteor.user().emails, (user) -> not user.verified

Template._loginButtonsAdditionalLoggedInDropdownActions.events # eslint-disable-line meteor/template-names
  'click #login-buttons-resend-verification': (e) ->
    Meteor.call 'resendVerificationEmail'
