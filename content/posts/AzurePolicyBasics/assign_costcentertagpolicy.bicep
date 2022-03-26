targetScope = 'managementGroup'

@description('The name of the tag that will be required')
param tagName string = 'CostCenter'
@description('The value of the tag that will be required')
param tagValue string = '0000'

resource assign_costcentertagpolicy 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'TagCostCenter0000'
  /*
  Identity is only required for remediation policies such as Modify or DeployIfNotExists

  identity: {
    type: 'SystemAssigned'
  }

  */ 
 
  properties: {
    displayName: 'All resources must have tag CostCenter set to 0000'
    description: 'Any deployed new resource that does not have the tag CostCenter set to 0000 will be denied'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/1e30110a-5ceb-460c-a204-c1c3969c6d62'
    parameters: {
      TagName: {
         value: tagName
      }
      TagValue: {
        value: tagValue
      }
    }
  }
}
