targetScope = 'subscription'

param principalId string
param roleDefinitionResourceId string

resource RoleAssignment 'Microsoft.Authorization/roleAssignments@2015-07-01' = {
  name: guid(subscription().id, principalId, roleDefinitionResourceId)
  properties: {
    principalId: principalId
    roleDefinitionId: roleDefinitionResourceId
  }
}
