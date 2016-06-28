Feito
  Mudar forma de salvar comentarios no create

    hoje está assim:
        prototipo.comentarios.create(
          comentarios
        ) if comentarios.present? && comentarios.any?
    deve se remover isso e acrescentar um parametro no model do prototipo
      ex:
        accepts_nested_attributes_for :comentarios

    assim, você ganha um parametro 'comentarios_attributes' e já salva direto no save do prototipo

    não esqueça de arrumar o seed

Feito

  Pesquisar uma forma de apagar os comentarios quando apaga o prototipo (sem fazer destroy)

Feito
  Criar scopes para buscar analista/desenvolvedor

    exe.: Pessoa.analistas
      deve vir todas as analistas

  Criar scopes para buscar etapas/status/categorias

    exe.: ConfigPrototipo.etapas
      deve vir todas as etapas

Feito
  Arrumar a configuração e os comentarios

    rota

Feito
  Arrumar categoria/status/etapa

    Back-end
      create, update
        prototipo.categoria # value
      index
        prototipo.categoria
          value, label

    Fron-end
      item, index
        prototipo.categoria
          value, label
      form
        prototipo.categoria # value

Feito
  tirar nuul false de
    Prototipo -> desenvolvedor, link, tarefas # tirar do seed
