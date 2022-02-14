targetScope = 'subscription'

@description('The role name')
param roleName string = 'Custom Owner'

var roleDefName = guid(subscription().id, roleName)

resource customOwner 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' = {
  name: roleDefName
  properties: {
    description: 'Grants full access to manage all resources, except edit the subscription properties'
    type: 'CustomRole'
    roleName: roleName
    assignableScopes: [
      subscription().id
    ]
    permissions: [
      {
        actions: [
          '*'
        ]
        notActions: [
            'Microsoft.Subscription/cancel/action'
            'Microsoft.Subscription/rename/action'
            'Microsoft.Subscription/enable/action'
        ]
        dataActions:[]
        notDataActions:[]
      }
    ]
  }
}
