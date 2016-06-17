# ruby encoding: utf-8

# Pessoas
  Pessoa.destroy_all

  TIPO = {
    desenvolvedor: 'Desenvolvedor',
    analista: 'Analista'
  }.freeze

  Pessoa.create!(
    [
      { nome: 'David Brahiam',        tipo: TIPO[:desenvolvedor] },
      { nome: 'Diego Felipe',         tipo: TIPO[:desenvolvedor] },
      { nome: 'Renato Jesus',         tipo: TIPO[:desenvolvedor] },
      { nome: 'José Eduardo',         tipo: TIPO[:analista] },
      { nome: 'Guilherme Nascimento', tipo: TIPO[:analista] },
      { nome: 'Júlio',                tipo: TIPO[:analista] }
    ]
  )

# Configurações de Prototipo
  ConfigPrototipo.destroy_all

  CATEGORIAS = [
    'Agenda',
    'App - Android',
    'App - IOS',
    'Arquitetura',
    'Bancos',
    'Biometria - Controle de Acesso',
    'Biometria - Ponto Eletrônico / Atrasos',
    'Cadastro de Clientes',
    'Cadastro de Morador',
    'Chat',
    'Câmeras',
    'Circulares',
    'Cobrança',
    'Condomínios',
    'Compras',
    'Contas',
    'CRM',
    'Controle de Acesso (Permissões)',
    'Contabilidade',
    'Dashboard',
    'Deploy',
    'Empréstimos (Chaves e Objetos)',
    'Demonstração',
    'Documentos',
    'Documentação',
    'Encomendas',
    'Estoque / Patrimônio',
    'Ferramentas / Serviços / Infra',
    'Financeiro / Acordos',
    'Financeiro / Boletos',
    'Financeiro / Cadastro Pessoas',
    'Financeiro / Cobranças',
    'Financeiro / Fração',
    'Financeiro / Lançamentos',
    'Financeiro / Leituras',
    'Financeiro / Ofertas',
    'Financeiro / Plano de Contas',
    'Financeiro / Previsões Orçamentárias',
    'Financeiro / Rateio',
    'Financeiro / Unidades',
    'Fornecedores',
    'Git',
    'Infrações',
    'Leituras (gás, luz e água)',
    'Manual de Uso do Software',
    'Menu',
    'Minhas Residências',
    'Mudanças',
    'Mural de Recados',
    'Notificações',
    'Ocorrências',
    'Pagamentos',
    'Passagem de Serviço',
    'Protótipo',
    'Recados',
    'Redmine',
    'Site SeuCondominio.com.br / CMS',
    'Site dos Clientes (Cond., Adm, Terc)',
    'Suporte',
    'SysAdmin',
    'Tarefas',
    'Templates',
    'Telefones Úteis',
    'Testes',
    'Uikit',
    'Usuário',
    'Visitantes',
    'Votações',
    'RF-id',
    'Blog'
  ].freeze

  ETAPAS = [
    'Pesquisa',
    'Mockup',
    'Validação',
    'Prototipação Front-End',
    'Prototipação Back-End'
  ].freeze

  STATUS = [
    'Aguardando',
    'Em Execução',
    'Concluído'
  ].freeze

  CATEGORIAS.each do |label|
    Categoria.create!(
      label: label, value: label.fileize
    )
  end

  ETAPAS.each do |label|
    Etapa.create!(
      label: label, value: label.fileize
    )
  end

  STATUS.each do |label|
    Status.create!(
      label: label, value: label.fileize
    )
  end
