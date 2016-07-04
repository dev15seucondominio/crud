angular.module 'PrototypeSc'

 .factory 'PrototipoConfig', [
  '$resource'
  ($resource)->

    encapsulateData = (data) ->
      return JSON.stringify { 'configs_prototipos': data }

    encapsulateData2 = (data) ->
      return JSON.stringify(JSON.decycle ({ 'configs_prototipos': data }))

    $resource '/prototipos/id/configs_prototipos/:id.json',
      { id: '@id' },
        create:
          method: 'POST'
          transformRequest: encapsulateData
        update:
          method: 'PUT'
          transformRequest: encapsulateData2
        destroy:
          method: 'DELETE'
  ]
