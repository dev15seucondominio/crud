angular.module 'PrototypeSc'

 .factory 'Prototipo', [
  '$resource'
  ($resource)->

    encapsulateData = (data) ->
      return JSON.stringify { 'prototipos': data }

    encapsulateData2 = (data) ->
      return JSON.stringify(JSON.decycle ({ 'prototipos': data }))

    $resource '/prototipos/:id.json',
      { id: '@id' },
        list:
          method: 'GET'
          toArray: true
        show:
          method: 'GET'
        create:
          method: 'POST'
          transformRequest: encapsulateData
        update:
          method: 'PUT'
          transformRequest: encapsulateData2
        destroy:
          method: 'DELETE'
  ]
