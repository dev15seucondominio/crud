angular.module 'PrototypeSc'

  .controller 'Item::Ctrl', [
    '$scope', 'Prototipos', '$filter', '$timeout', 'scAlert', 'scTopMessages', 'scToggle'
    (sc, Prototipos, $filter, $timeout, scAlert, scTopMessages, toggle)->

      sc.initForm = (prototipo)->
        sc.prototipo = prototipo
        sc.prototipo.acc = new toggle
          onOpen: ->
            load_prototipo()

      load_prototipo = ()->
        return if sc.prototipo.carregando || sc.prototipo.carregado
        sc.prototipo.carregando = true
        Prototipos.show {id: sc.prototipo.id},
          (data)->
            sc.prototipo = angular.extend sc.prototipo, data
            sc.prototipo.carregado = true
            sc.prototipo.carregando = false
          (resp)->
            console.log 'Erro show'
            sc.prototipo.carregando = false

      sc.deletarComentario = (comentario)->
        Prototipos.comentarios_destroy comentario,
          (data)->
            index = sc.prototipo.comentarios.indexOf comentario
            sc.prototipo.comentarios.splice index, 1
          (resp)->
            sc.formPrototipo.erros = resp.data.erros
            console.log resp.data

      sc.deletarAlert = (prototipo)->
        scAlert.open
          title: 'Excluir registro?'
          messages: 'Você não será capaz de recuperar esse registro!'
          buttons: [
            {
              label: 'Cancelar'
              color: 'red'
            }
            {
              label: 'Confirmar'
              color: 'green'
              action: ()->
                sc.deletar(prototipo)

            }
          ]

      sc.toggleAcc = (obj)->
        f.acc.close() for f in sc.prototipos unless obj.acc.opened
        obj.acc.toggle()

      sc.deletar = (prototipo)->
        Prototipos.destroy prototipo,
          (data)->
            index = sc.prototipos.indexOf prototipo
            sc.prototipos.splice index, 1
            scTopMessages.openSuccess "Registro excluído com sucesso!", {timeOut: 3000}
          (resp)->
            scTopMessages.openDanger "Erro ao deletar, porfavor recarregue a página!", {timeOut: 3000}
            console.log resp.data

      sc.actionMenu = (prototipo, item)->
        switch item.name
          when 'Editar'
            load_prototipo()
            sc.formPrototipo.init_form(prototipo)
          when 'Excluir'
            sc.deletarAlert(sc.prototipo)

      sc.enviarComentario = (comentario)->
        if comentario != undefined && comentario != ''
          sc.comentarioError = false
          sc.error = false
          comentario.prototipo_id = sc.prototipo.id
          Prototipos.comentarios_create comentario,
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
  ]
