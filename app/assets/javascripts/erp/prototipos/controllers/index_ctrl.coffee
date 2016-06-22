angular.module 'PrototypeSc'

.controller 'Prototype::IndexCtrl', [
  '$scope', 'Prototipos', '$scModal', 'scAlert', '$timeout', 'scToggle','scTopMessages', '$routeParams', 'PrototiposConfigs'
  (sc, Prototipos, $scModal, scAlert, $timeout, toggle, scTopMessages, routeParams, PrototiposConfigs)->
    sc.prototipos = []

    sc.with_settings = true

    sc.init = ()->
      sc.filtro.buscar with_settings: sc.with_settings

    sc.dadosGerais =
      menu: [
        {
          name: 'Editar'
          icon: 'sc-icon sc-icon-lapis'
          # iconColor: 'sc-text-yellow'
        }
        {
          name: 'Excluir'
          icon: 'sc-icon sc-icon-lixeira-1'
          iconColor: 'sc-text-red'
        }
        {
          name: 'Histórico'
          icon: 'sc-icon-historico'
          # iconColor: 'sc-text-blue'
        }
      ]

    sc.typesConfigs =
      modal: new $scModal()
      init: (type)->
        @type = type
        @preparar()
        @modal.open()
      preparar: ->
        @carregando = true

        @listOrSelect()

        @carregando = false
      select: (obj)->
        @listOrSelect obj
        @fechar()
      listOrSelect: (obj = null)->
        sc.formPrototipo.params ||= {} if obj?
        if @type == 'categoria'
          if obj?
            sc.formPrototipo.params.categoria =
              label: obj.label
              value: obj.value
          else
            @list = sc.categorias
        else if @type == 'etapa'
          if obj?
            sc.formPrototipo.params.etapa =
              label: obj.label
              value: obj.value
          else
            @list = sc.etapas
        else if @type == 'status'
          if obj?
            sc.formPrototipo.params.status =
              label: obj.label
              value: obj.value
          else
            @list = sc.status
      salvar: ()->
        params = angular.extend { type: @type }, @params
        PrototiposConfigs.create params,
          (data)->
            sc.handleList sc.typesConfigs.list, data
            sc.typesConfigs.limpar()
          (resp)->
            console.log resp
            return
      delete: (obj)->
        PrototiposConfigs.destroy obj,
          (data)->
            index = sc.typesConfigs.list.indexOf obj
            sc.typesConfigs.list.splice index, 1
          (resp)->
            console.log resp.data
      update: ()->
        PrototiposConfigs.update @params,
          (data)->
            sc.handleList sc.typesConfigs.list, data
          (resp)->
            console.log resp.data
        @cancelar()
      editar: (obj)->
        @params = angular.extend {}, obj
      cancelar: ()->
        @limpar()
      limpar: ()->
        @params = {}
      fechar: ()->
        @limpar()
        sc.formPrototipo.modal.open()

    sc.filtro =
      avancado: new toggle
      buscar: (opt = {})->
        return if sc.carregando
        sc.carregando = true
        params = angular.extend opt, @params
        @change_avancada()
        Prototipos.list params,
          (data)->
            if sc.with_settings
              sc.categorias = data.categorias
              sc.relevancias = data.relevancias
              sc.status = data.status
              sc.etapas = data.etapas
              sc.analistas = data.analistas
              sc.desenvolvedores = data.desenvolvedores
              sc.with_settings = false

            sc.prototipos = data.lista
            sc.carregando = false

            sc.filtro.avancado.close() if sc.filtro.busca_avancada
          (resp)->
            console.log resp
      clear:()->
        @params = {}
        @buscar()
        @avancado.close()
      change_avancada: ()->
        if @params?.q? && !@avancado.opened
          @busca_avancada = false
        else if @avancado.opened
          @busca_avancada = true
        else
          @busca_avancada = null

    sc.formPrototipo =
      modal: new $scModal()
      params: {}
      init_form: (opt = {})->
        params =
          tarefas: [{value: ''}]
        @params = angular.extend opt, params
        @errors = null
        @modal.open()
      nova_tarefa: ()->
        console.log @params.tarefas
        @params.tarefas.push {}
      apagar_tarefa: (index)->
        @params.tarefas.splice index, 1
      criar: ()->
        Prototipos.create @params,
          (data)->
            sc.handleList sc.prototipos, data
            sc.formPrototipo.fechar()
          (resp)->
            sc.formPrototipo.errors = resp.data.errors
            console.log resp.data
      update: ()->
        Prototipos.update @params,
          (data)->
            sc.handleList sc.prototipos, data
            sc.formPrototipo.fechar()
          (resp)->
            sc.formPrototipo.errors = resp.data.errors
            console.log resp.data
      fechar: ()->
        @params = {}
        @errors = null
        @modal.close()

    sc.handleList = (list, obj)->
      addOrExtend = (list, obj)->
        indexOfById = (list, id)->
          index = 0
          for i in list
            return index if parseInt(i.id) == parseInt(id)
            index++
          -1

        idx = if obj.id? then indexOfById(list, obj.id) else list.indexOf(obj)
        if idx is -1
          list.unshift obj
        else
          angular.extend list[idx], obj

      addOrExtend(list, obj)
]
