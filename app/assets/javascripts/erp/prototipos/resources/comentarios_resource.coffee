angular.module 'PrototypeSc'

 .factory 'Comentarios', [
  '$resource'
  ($resource)->

    encapsulateData = (data) ->
      return JSON.stringify { 'comentarios': data }

    $resource '/prototipos/id/comentarios/:id.json',
      { id: '@id' },
        create:
          method: 'POST'
          transformRequest: encapsulateData
        destroy:
          method: 'DELETE'
  ]
