angular.module 'PrototypeSc'

 .factory 'Prototipos', [
  '$resource'
  'scAlert'
  'scTopMessages'
  ($resource, scAlert, scTopMessages)->

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
        comentarios_create:
          method: 'POST'
          url: '/prototipos/comentarios'
          transformRequest: (data) ->
            return JSON.stringify { 'comentarios': data }
        comentarios_destroy:
          method: 'DELETE'
          url: '/prototipos/comentarios'
          transformRequest: (data) ->
            return JSON.stringify { 'comentarios': data }
        update:
          method: 'PUT'
          transformRequest: encapsulateData2
        destroy:
          method: 'DELETE'
  ]
