angular.module 'PrototypeSc'

.controller 'Prototype::IndexCtrl', [
  '$scope', 'Prototipos', '$scModal', 'scAlert', '$timeout', 'scToggle','scTopMessages', '$routeParams'
  (sc, Prototipos, $scModal, scAlert, $timeout, toggle, scTopMessages, routeParams)->
    sc.formulario = new $scModal()
    sc.addCategoria =  new $scModal()

    sc.configs = [
      {
        id: 0
        formConfig:
          config: 'we'

      }
      {
        id: 1
        formConfig:
          config: 'a\qwewqew/\we'

      }
      {
        id: 2
        formConfig:
          config: 'weqewqekwqopewqkepqwek'

      }
      {
        id: 3
        formConfig:
          config: 'w3434324e'

      }
    ]

    sc.updateConfig = (categorias)->
      sc.configs.formConfig = sc.configs[sc.configs.indexConfig]
      sc.configs.formConfig.formConfig.config = categorias
      sc.trocar()

    sc.deletConfig = (index)->
      sc.configs.splice index, 1

    sc.trocar = (categoria)->
      sc.editarCategoria = !sc.editarCategoria
      sc.configs.formConfig=[]

    sc.editarCategorias = (categoria)->
      console.log categoria
      sc.editarCategoria = !sc.editarCategoria
      sc.configs.formConfig = angular.copy categoria.formConfig
      sc.configs.indexConfig = sc.configs.indexOf categoria
      console.log sc.configs.formConfig

    sc.novaCategoria = (configs)->
      sc.configs.push
        formConfig:
          config: configs.formConfig.config
      configs.formConfig = ''

    sc.with_settings = true
    sc.prototipos = []

    sc.check = ($event)->
      keyCode = $event.which or $event.keyCode
      if keyCode == 13
        sc.filtro.buscar()

    sc.init = ()->
      sc.filtro.buscar({with_settings: sc.with_settings})

    sc.formCadastro = ()->
      sc.formPrototipo = []
      sc.formulario.open()

    sc.editarForm = (prototipo)->
      sc.formPrototipo.params = angular.copy prototipo
      sc.formPrototipo.indexPrototipo = sc.prototipos.indexOf prototipo
      sc.formPrototipo.errors = null
      sc.formulario.open()

    sc.addTarefa = ()->
      sc.teste.push
        campo: ''

    sc.eliminarTarefa = (index)->
      sc.teste.splice index, 1

    sc.teste = [{}]

    sc.searching = (o)->
      sc.f = o
      sc.filtros = false

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

    sc.limparBusca = ()->
      sc.filtro.params =[]
      sc.s = ''

    sc.clear = ()->
      sc.limparBusca()
      sc.filtro.buscar()
      sc.filtro.open = false

    sc.filtro =
      _open: false
      buscar: (opt = {})->
        return if sc.carregando
        sc.carregando = true
        params = angular.extend opt, @params
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
            sc.filtroFunil()
          (resp)->
            console.log resp


    sc.filtroFunil = ()->
      sc.filtro.q = true
      switch sc.filtro.open
        when true
          sc.s = sc.filtro.params.q
          sc.filtro.params.q = ''
        when false
          sc.filtro.params.q = sc.s

    sc.objTemp = {}

    sc.novaEntrega =
      _new: false
      dados:
        params: {}

    sc.formPrototipo =
      params:
        link: ''
        nome: ''
        etapa: ''
        status:''
        mockup:''
        tarefas: ''
        analista:''
        categoria: ''
        relevancia: ''
        desenvolvedor: ''
        comentarios:[
          id: ''
          nome: ''
          mensagem: ''
        ]

    sc.novo = ()->
      Prototipos.create sc.formPrototipo.params,
        (data)->
          sc.formPrototipo.errors = null
          sc.prototipos.unshift data
          sc.formulario.close()
        (resp)->
          sc.formPrototipo.errors = resp.data.errors
          console.log resp.data

    sc.update = ()->
      Prototipos.update sc.formPrototipo.params,
        (data)->
          sc.formulario.close()
          sc.formPrototipo.errors = null
          sc.prototipos[sc.formPrototipo.indexPrototipo] = data
        (resp)->
          sc.formPrototipo.errors = resp.data.errors
          console.log resp.data
]
