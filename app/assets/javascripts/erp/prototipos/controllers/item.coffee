angular.module 'PrototypeSc'

  .controller 'Item::Ctrl', [
    '$scope', 'Prototipo', '$filter', '$timeout', 'scAlert', 'scTopMessages', 'scToggle', 'Comentario'
    (sc, Prototipo, $filter, $timeout, scAlert, scTopMessages, toggle, Comentario)->

      sc.initForm = (prototipo)->
        sc.prototipo = prototipo
        sc.prototipo.acc = new toggle
          onOpen: ->
            sc.load_prototipo()

      sc.objComentario =
        deletarComentario: (comentario)->
          Comentario.destroy comentario,
            (data)->
              index = sc.prototipo.comentarios.indexOf comentario
              sc.prototipo.comentarios.splice index, 1
            (resp)->
              sc.formPrototipo.erros = resp.data.erros
              console.log resp.data
        enviarComentario: (comentario)->
          if comentario != undefined && comentario != ''
            sc.comentarioError = false
            sc.error = false
            comentario.prototipo_id = sc.prototipo.id
            Comentario.create comentario,
              (data)->
                comentario.nome = ''
                comentario.mensagem = ''
                sc.prototipo.comentarios.push data
              (resp)->
                sc.formPrototipo.erros = resp.data.erros
                console.log resp.data
          else
            sc.mensagemError = true
            sc.error = true

      sc.load_prototipo = ()->
        return if sc.prototipo.carregando || sc.prototipo.carregado
        sc.prototipo.carregando = true
        Prototipo.show {id: sc.prototipo.id},
          (data)->
            sc.prototipo = angular.extend sc.prototipo, data
            sc.prototipo.carregado = true
            sc.prototipo.carregando = false
          (resp)->
            console.log 'Erro show'
            sc.prototipo.carregando = false

      sc.toggleAcc = (obj)->
        f.acc.close() for f in sc.prototipo unless obj.acc.opened
        obj.acc.toggle()

  ]
