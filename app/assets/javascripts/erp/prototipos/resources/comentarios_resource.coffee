angular.module 'PrototypeSc'

 .factory 'Comentarios', [
  '$resource'
  'scAlert'
  'scTopMessages'
  ($resource, scAlert, scTopMessages)->

    encapsulateData = (data) ->
      return JSON.stringify { 'comentarios': data }

    $resource '/comentarios/:id.json',
      { id: '@id' },
        create:
          method: 'POST'
          transformRequest: encapsulateData
        destroy:
          method: 'DELETE'
  ]
