targetScope = 'managementGroup'

resource MyOrgName 'Microsoft.Management/managementGroups@2021-04-01' = {
  scope: tenant()
  name: 'MyOrgName'
  properties:{
    displayName: 'MyOrgName'
    details:{
      parent:{
        id:managementGroup().id
      }
    }
  }
}

resource Platform 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'Platform'
  scope:tenant()
  properties:{
    displayName: 'Platform'
    details:{
      parent:{
        id:MyOrgName.id
      }
    }
  }
}

resource Identity 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'Identity'
  scope:tenant()
  properties:{
    displayName: 'Identity'
    details:{
      parent:{
        id:Platform.id
      }
    }
  }
}

resource Management 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'Management'
  scope:tenant()
  properties:{
    displayName: 'Management'
    details:{
      parent:{
        id:Platform.id
      }
    }
  }
}

resource Connectivity 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'Connectivity'
  scope:tenant()
  properties:{
    displayName: 'Connectivity'
    details:{
      parent:{
        id:Platform.id
      }
    }
  }
}

resource LandingZones 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'LandingZones'
  scope:tenant()
  properties:{
    displayName: 'Landing Zones'
    details:{
      parent:{
        id:MyOrgName.id
      }
    }
  }
}

resource SAP 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'SAP'
  scope:tenant()
  properties:{
    displayName: 'SAP'
    details:{
      parent:{
        id:LandingZones.id
      }
    }
  }
}

resource Corp 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'Corp'
  scope:tenant()
  properties:{
    displayName: 'Corp'
    details:{
      parent:{
        id:LandingZones.id
      }
    }
  }
}

resource Online 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'Online'
  scope:tenant()
  properties:{
    displayName: 'Online'
    details:{
      parent:{
        id:LandingZones.id
      }
    }
  }
}

resource Decommissioned 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'Decommissioned'
  scope:tenant()
  properties:{
    displayName: 'Decommissioned'
    details:{
      parent:{
        id:MyOrgName.id
      }
    }
  }
}

resource Sandbox 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'Sandbox'
  scope:tenant()
  properties:{
    displayName: 'Sandbox'
    details:{
      parent:{
        id:MyOrgName.id
      }
    }
  }
}
