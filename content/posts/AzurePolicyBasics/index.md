--- 

title: "Azure Policies, the basics" 

date: 2022-03-26T15:24:45+01:00 

draft: false

comments: true 

toc: false

images:

tags:
  - Azure
  - Bicep
  - PowerShell
--- 
![policy.png](policy.png)

When an organization decides to provision applications and infrastructure components in the cloud, security has to be taken into consideration. To mitigate human security mistakes it can be wise to put some guardrails around your cloud environments. The amounts of guardrails chosen depends on organisation size, developer experience level and security posture, as well as network topologies and possible connections to the on-premise company systems. In Azure, the Azure policies allow you to reduce the risk of having your environment being compromised by human error and risky configurations, either unintended or with malicious intent.

Azure policies can audit, deny, append and modify resource configurations that introduce unnecessary risk. You can also deploy complementary resources with a certain configuration where missing, for example you can automatically deploy a network security group for every created subnet, if your application teams have failed to do so. 

The use of policies can be powerful, but also hampers your developers freedom. You should always weigh the ease of working, against the security gained when you assign a policy. There is no "golden path" for every single case here, you will have to adapt your security governance to the organisations needs and security posture. When you define and assign the policies, think about what the desired outcome is and how you can achieve that outcome with a minimum of hassle for your application teams.

##### This guide depends on the following:

|Tool | Link |
| ----------- | ----------- |
|Azure Bicep Cli | [Bicep Cli install instructions](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)|
|VSCode + Bicep Extension | [Getting Up And Ready With VSCode](/blog/posts/gettingupandreadywithvscode/) and [VSCode Productivity hints](/blog/posts/vscodeproductivity/)|
|Azure Powershell | [Setup Azure Powershell ](/blog/posts/setupazpowershell/)|
|Azure Account | [Register Free Azure Account ](/blog/posts/registerfreeazureaccount/)|

## Policy Definitions
First and foremost, all Azure policies are defined by Policy Definitions. A Policy Definition describes the conditions for when the policy will apply, how the policy is enforced and what parameters that can be supplied to the policy. Microsoft has provided a large variety of *built-in* policies, that you can assign without having to author your own *Custom* policy. You can find all these in the Azure Portal Policy blade by clicking *definitions*. The *type* column shows if the policy is built-in or custom made. I usually just type *policy* in the main search bar of the Azure portal to bring up the policy blade. However you can open the policy blade from management groups, subscriptions and resource groups, as these are the *scopes* where you can store policy definitions and make policy assignments.

## Policy Initiatives / Sets
You can group policy definitions into something called *initiatives* or* policy sets* . This will enable you to assign a group of policies to a scope with a single assignment and helps grouping policies that server a common purpose.

## Policy Assignments
The Policy Assignments is what links the Policy Definitions or Initiatives/PolicySets to an Azure Scope, such as a Management Group, Subscription or Resource Group. When assigning the policy, parameters can be provided. This will make it possible to make multiple assignments of a policy in the same scope, with different paramter values set in each, and also make it possible to use a policy definition for assignments in several different subordinate scopes.

# Assigning Policies
To assign a policy you can either use the Azure Portal, use PowerShell or make a Bicep/ARM deployment of a policyassignment. I won't show how to do it in the portal as I think it's rather self explanatory if you open the policy blade.

Let's assign a simple tag policy to the *SAP* Management group scope.

## Find the policy in the Azure portal
Open up Managment Groups in the portal and then click the *Policy* in the left side menu. Then open *definitions* and search the policies for the keyword *Tag*, select the policy *Require a tag and its value on resources*. Copy the definition id in order to use it in your assignment.

## PowerShell
Here is how you make a policyassignment using PowerShell.

```PowerShell
Connect-AzAccount

$ManangementGroup = Get-AzManagementGroup 'SAP'

$ManangementGroup.Id
# Outputs /providers/Microsoft.Management/managementGroups/SAP
# This is the Scope you will assign the policy to


# Here you will use the Id you copied from the policydefinition in the Azure Portal
$PolicyDefinition = Get-AzPolicyDefinition -Id '/providers/Microsoft.Authorization/policyDefinitions/1e30110a-5ceb-460c-a204-c1c3969c6d62'

#Splatting the parameters for New-AzPolicyAssignment
$Params = @{
    Name = 'TagCostCenter0000'
    DisplayName = 'All resources must have tag CostCenter set to 0000'
    PolicyDefinition = $PolicyDefinition
    Scope = $ManangementGroup.Id
    TagName = 'CostCenter'
    TagValue = '0000'
}

New-AzPolicyAssignment @Params
```

### Cleaning up
If you want to remove the policy assignment at a later time, you can use PowerShell again in a similar way.

```PowerShell
Connect-AzAccount

$ManangementGroup = Get-AzManagementGroup 'SAP'

$ManangementGroup.Id
# Outputs /providers/Microsoft.Management/managementGroups/SAP
# This is the Scope you will unassign the policy from

# Removes the policy assignment
Remove-AzPolicyAssignment -Name 'TagCostCenter0000' -Scope $ManangementGroup.Id
```

## Bicep
I like to deploy policyassignments using Bicep, as it provides a way to store all the details of the assignments in a nice readable format and you can easily version control the Bicep files. Another reason I like to deploy using template deployments (Bicep or ARM) is that if you would use Azure Cli or PowerShell cmdlets and loops to deploy each resource, it would call the Azure ARM Api once for every resource instead of just calling the Api once to deliver the deployment template. 

With Bicep you can also bundle other resources together with the policy assignment and deploy to the same scope, as a nice package. Once a deployment has been submitted to Azure, the deployment will be carried out by Azure Resource manager independently of your PowerShell session. You'll notice that this is way more efficient when deploying lot's of resources in a single deployment. I prefer to use Bicep rather than ARM when suitable, because of the simplified syntax and the VSCode intellisense support for Bicep.

### Create the Bicep file
Download the Bicep file [assign_costcentertagpolicy.bicep](assign_costcentertagpolicy.bicep). It's a good idea to write your own bicep file and use the downloaded as reference, just to learn the syntax and the logic of the bicep files. Remember that `Ctrl+Space` will give you intellisense syntax help.

##### targetScope
We are deploying this template to a managementGroup, the targetScope must match the scope we deploy to.

##### @*decorator*
The decorators for the tagName and tagValue parameters, these decorators provides descriptions for the parameters. There are other decorators available like "allowed(values)", you can see what's available if you just type the *@* sign in the row above the parameter declaration, VSCode will bring up the Bicep intellisense.

##### param tagName string
This is a parameter, we will set the tagName defaultvalue to 'CostCenter'.

##### param tagValue array 
This is a parameter, we will set the tagName defaultvalue to '0000'.

##### resouce assign_costcentertagpolicy
This is the policy assignment resource.

##### name:
The name of the policy assignment, will be used in the resourceId for the policy assignment.

##### /* */
Remarked section (starting with /* and ending with */), this is just to show how to make the assignment for a remediation policy, remediation tasks require an indentity that will carry out the remediations.

##### properties
The properties of this policy assignment.

##### displayName
The name of the policy assignment that will be displayed in the Azure portal.

##### description
The description of the policy assignment that will be displayed in the Azure portal.

##### policyDefinitionId
The id of the policy definition that will be assigned.

##### parameters
In this key all the input parameters for the policy definition will be populated.

##### tagName
The first parameter that will be consumed by the policy definition, this value is consumed from the tagName parameter declared earlier in the bicep, using the defaultvalue 'CostCenter' if nothing else is provided when deploying.

##### tagValue
The second parameter that will be consumed by the policy definition, this value is consumed from the tagValue parameter declared earlier in the bicep, using the defaultvalue '0000' if nothing else is provided when deploying.

### Deploy the policy assignment
First you always need to authenticate your session to Azure, if have done so, but your session to Azure has expired, you may need to re-authenticate.

```PowerShell
Connect-AzAccount
```

Now you can go ahead with deployment. 

Note that I have chosen to deploy my policy assignment to the managementgroup 'SAP' that was created in a previous [blogpost](/blog/posts/managementgroups/). In *Location* you can use your Azure location of preference.

```PowerShell
#Splatting parameters to make it more readable
$Params = @{
    ManagementGroupId = 'SAP'
    Templatefile = '.\assign_costcentertagpolicy.bicep'
    Location = 'WestEurope'
    Name = 'PolicyAssigndeploy'
}

#Deploy the Assignment
New-AzManagementGroupDeployment @Params
```

### Cleaning up
If you want to remove the policy assignment at a later time, can clean up both the assignment and the deployment details.

```PowerShell
# Removes the policy assignment
$ManangementGroup = Get-AzManagementGroup 'SAP'
Remove-AzPolicyAssignment -Name 'TagCostCenter0000' -Scope $ManangementGroup.Id

# This line removes the deployment, but does not remove the assignment itself
Remove-AzManagementGroupDeployment -ManagementGroupId 'SAP' -Name 'PolicyAssigndeploy'
```

# Conclusion
This was two ways to assign policies using code, using Azure Cli is very similar to using PowerShell, but there are also other ways to do this using code, but I won't be covering other ways here. Next we will look into how to make Policy Initiatives / Policy Sets and how to author your own Custom Policies - stay tuned!

**Please follow me on [LinkedIn](https://www.linkedin.com/in/peter-the-automator/) and let me know if you like my blog.**

