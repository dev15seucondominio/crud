angular.module 'PrototypeSc'

 .factory 'PrototiposConfigs', [
  '$resource'
  'scAlert'
  'scTopMessages'
  ($resource, scAlert, scTopMessages)->

    encapsulateData = (data) ->
      return JSON.stringify { 'configs_prototipos': data }

    encapsulateData2 = (data) ->
      return JSON.stringify(JSON.decycle ({ 'configs_prototipos': data }))

    $resource '/configs_prototipos/:id.json',
      { id: '@id' },
        list:
          method: 'GET'
          toArray: true
        create:
          method: 'POST'
          transformRequest: encapsulateData
        update:
          method: 'PUT'
          transformRequest: encapsulateData2
        destroy:
          method: 'DELETE'
  ]
