targetScope = 'managementGroup'

@description('The full resource ID of the billing scope to use for these subscriptions.')
param billingScope string
param Subscriptions array

/*
You can define the subscription details as an array in the bicep file 
instead of sending your sending them as a parameterobject.
Below is an example of how to do that.


var Subscriptions array = [
  {
    Name: 'Azure Prod Subscription 1'
    Workload : 'Production'
  } 
  {
    Name: 'Azure Prod Subscription 2'
    Workload: 'Production'
  }
]
*/

resource subscriptionAliases 'Microsoft.Subscription/aliases@2021-10-01' = [for sub in Subscriptions:{
  scope:tenant()
  name: guid(sub.Name)

  properties: {
    billingScope: billingScope
    displayName: sub.Name
    additionalProperties: {
      managementGroupId: managementGroup().id
      // /providers/Microsoft.Management/managementGroups/<managementGroupId>
    }
    workload: sub.Workload
  }
}]

output deployedSubscriptions array = [for (Sub, i) in Subscriptions: {
  deployedSubscription: subscriptionAliases[i]
}]
