--- 

title: "Azure Roles" 

date: 2022-02-12T10:10:45+01:00 

draft: false

comments: true 

toc: false

images:

tags:
  - Azure
  - Bicep
  - PowerShell
--- 

![roles.png](roles.png)

In Azure, access and control of any resources is managed through *Role based access control* (RBAC). By being assinged a role, a user will be able to access or manage different aspects of a resource and/or it's subordinate resources.

## This guide depends on the following:

|Tool | Link |
| ----------- | ----------- |
|Azure Bicep Cli | [Bicep Cli install instructions](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)|
|VSCode + Bicep Extension | [Getting Up And Ready With VSCode](/blog/posts/gettingupandreadywithvscode/) and [VSCode Productivity hints](/blog/posts/vscodeproductivity/)|
|Azure Powershell | [Setup Azure Powershell ](/blog/posts/setupazpowershell/)|
|Azure Account | [Register Free Azure Account ](/blog/posts/RegisterFreeAzureAccount/)|

# Scopes
The roles will be given permissions on a *Scope*. To determine what a user is authorized to do in a specific scope, Azure checks what roles assignments are made to the scope you are trying to access. 

Scopes can be anything from an entire tenant to a managementgroup, subscription, resourcegroup or resource, basically anything you can manage in Azure. These are referred to as the resource Id.

![rbac-scope-no-label.png](rbac-scope-no-label.png)

Read more about scopes at [Microsoft Docs](https://docs.microsoft.com/en-us/azure/role-based-access-control/scope-overview#:~:text=In%20Azure%2C%20you%20can%20specify,of%20these%20levels%20of%20scope.)

# Role Assignments and Role Definitions

Role assignments are the components that tells Azure what permissions a user (identity) has been granted to a scope. 

![roles.png](roles.png)

The Role assignment itself basically just links a *role definition* and a *principal* (identity) to a *resource scope*. The actual permissions are defined in the *role definition*. There can be many role assignments made for a single role definition.

All role assignments and role definitions in a certain scope, can be listed by simply looking in the Azure portal under Access control (IAM), this applies to almost any type of object you can manage in the portal.

![IAM.png](IAM.png)

- You can see all assignable role-**assignments** in a scope by clicking the *Role assignments* tab. 

- You can see all assignable role-**definitions** in a scope by clicking the *Roles* tab in the *Access control (IAM)* page. 

# Role assignments

Open a subscription in your Azure environment and open the *Access control (IAM)* page and the *Role Assignments* tab. Here all the role assignments made for this scope will be listed. You can see in the *Scope* column where the role that applies for this subscription was assigned. If you don't already have any assignments directly to this resource, try adding one by clicking the *+ Add* button to make a new role assignment. Select the *Owner* role, click next, click *+ Select members* and then add your own account, finish by clicking *Review + Assign*. When the assignments is ready you should see it in the list.

## Let's check the JSON represenation for this role assignment!
The portal doesn't have a nice button where you can see the JSON representation of a role assignment, but you can get them with the Azure resource manager (ARM) API, the simplest way is by using either Azure Cli or PowerShell.

## ---- Verify syntax ----!

To get all the role assignments for your subscription, use the PowerShell command below. The *Scope* should be a resource identifier, for a subscription it looks like this: */subscriptions/00000000-0000-0000-0000-000000000000*.

Replace the zeroes with your subscription Id.

**PowerShell**
```PowerShell
#List all role assignments in a given scope
Get-AzRoleAssignment -Scope '/subscriptions/00000000-0000-0000-0000-000000000000'
```

## Let's look a the JSON of your assignment of the *'owner'* role!
In the previous command there was a list of role assignments. To get a single role assignment you can use the *ObjectID* of that assignment as an argument to Get-AzRoleAssignment. The output will you the role assignment JSON representation.

```PowerShell
#List the role assignments in a given scope
Get-AzRoleAssignment -ObjectID 'InsertObjectID'
```

### id: 
This is the Unique Identifier for this role-assignment. This is the id refered to when doing a role-assignment.

### name:
This is the name of the role assignment.

### properties:
#### **principalId:**
This is the Id of the principal (user account or managed identity) that you want to give permissions to.

#### **roleDefinitionId:**
This is the Id of the role definition you want to apply for this user.

# Role Definitions

You can see all assignable role-definitions in a scope by clicking the "Roles" tab in the *Access control (IAM)* page. By clicking the (Details) "View" link on the right you can see the permissions of a role. If you then click the "JSON" tab, you will see the JSON representation of the role, this is basically what you will use when you make new role-definition as code.

## ---- Verify syntax ----!

**You can retrieve them with PowerShell, just like you did with the role assignments.**
```PowerShell
#List all role definitions in a given scope
Get-AzRoleDefinition -Scope '/subscriptions/00000000-0000-0000-0000-000000000000'
```
This will output the role definition JSON representation to your PowerShell output.

## Let's look a the JSON on the bult-in *owner* role!

### id:
This is the Unique Identifier for this role-definition. This is the id refered to when doing a role-assignment.

### properties:
**roleName:** The displayname of this role, please note that it is not unique, that means that two different role-definitions with the same name can be defined in two different scopes. You can use GUID's to make the name unique.

# Verify that it's not unique

**description:** A freetext description field that should briefly and simplified describe what permissions this role gives.

**assignableScopes:** This is a list of all the scopes where this role definition can be assigned. Microsoft uses this property in to enable moving resouces between different scopes without having to make new role-definitions and assignments, in short - use the "/" scope here unless you are migrating things. This list is a JSON array, all scopes will be listed within the *[]*.

**permissions:** In this key you will define the actual permissions that the role gives. Note that the permissions key is a JSON array [ ], with (theoretical) possibility to have more than one list of permissions. However I have never tried to pull off that stunt. 

Every key in a permissions item is another JSON array [ ], which means that you can make lists of *actions*, *notActions* etc.

- *actions* lists all the actions that this role can make, for the *owner* role this is just the wildcard * for everything.
- *notActions* lists every action that you explicitly want to deny from this role, by listing things here, you can take away some of the permissions that were listed in *actions*.
- *dataActions* lists all the dataActions that this role can make, this controls what the role can do with the data inside a resource, for example access to the files in a storage account. In Azure the controlplane for resource objects is separated from the dataplane in the resources.
- *notDataActions* lists every dataAction that you explicitly want to deny from this role, by listing things here, you can take away some of the permissions that were listed in *dataActions*.

# Custom Roles
There might be reasons you want to make your own custom roles to limit the amount of permissions you give away in your organisation. For example you may not want your application teams to be able to cancel, rename, or create subscriptions on their own, or even move them into another organisations Azure Active directory tenant.

Craft your role definition to you liking and then you can push it to Azure, either by using the Azure portal, ARM Api, Cli or PowerShell.






# Conclusion
Now you know a way to deploy subscriptions as code. This technique can be one piece of the puzzle to automate your subscription deployment process. 

**Please follow me on [LinkedIn](https://www.linkedin.com/in/peter-the-automator/) and let me know if you like my blog.**

