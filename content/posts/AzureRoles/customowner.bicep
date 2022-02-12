targetScope = 'managementGroup'

param AssignableScopes array

@description('A new GUID used to identify the role definition')
param roleName string

resource ScaniaOwner 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' = {
  name: roleName
  properties: {
    description: 'Grants full access to manage all resources, except edit the subscription properties'
    type: 'CustomRole'
    roleName: 'Scania Owner'
    assignableScopes: AssignableScopes
    permissions: [
      {
        actions: [
          '*'
        ]
        notActions: [
          'Microsoft.Subscription/cancel/action'
          'Microsoft.Subscription/rename/action'
          'Microsoft.Subscription/enable/action'
          'Microsoft.Subscription/CreateSubscription/action'
          'Microsoft.Subscription/updateTenant/action'
          'Microsoft.Subscription/Subscriptions/write'
          'Microsoft.Subscription/aliases/write'
          'Microsoft.Subscription/aliases/read'
          'Microsoft.Subscription/aliases/delete'
          'Microsoft.Authorization/roleDefinitions/write'
          'Microsoft.Authorization/roleDefinitions/delete'
        ]
      }
    ]
  }
}
