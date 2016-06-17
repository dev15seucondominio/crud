Deletar migrations e renomear tudo para Prototipos ou Prototipo conforme o caso

Criar Comentarios

  # rails g migration create_comentarios
  create_table :comentarios, force: :cascade do |t|
    t.belongs_to :prototipo, null: false
    t.string :nome,          null: false
    t.text :mensagem,        null: false

    t.timestamps null: false
  end

  # criar uma arquivo comentario.rb no app/models
  class Comentario < ActiveRecord::Base
    belongs_to :prototipo, class_name: 'Prototipo'

    validate :nome, :mensagem, presence: { message: 'Não pode ser vazio.' }

    def to_frontend_obj
      {
        id: id,
        nome: nome,
        mensagem: mensagem
      }
    end
  end

Criar Prototipos

  # rails g migration create_prototipos
  create_table :prototipos, force: :cascade do |t|
    t.text   :nome,         null: false
    t.string :categoria,    null: false
    t.text   :mockup,       null: false
    t.text   :link,         null: false
    t.string :etapa,        null: false
    t.string :status,       null: false
    t.string :analista,     null: false
    t.string :desenvolvedor
    t.string :relevancia

    t.timestamps null: false
  end

  # criar uma arquivo prototipo.rb no app/models
  class Prototipo < ActiveRecord::Base
    validate :nome, :categoria, :mockup, :link, :etapa,
             :status, :analista, presence: { message: 'Não pode ser vazio.' }

    validates :categoria, :etapa, :status, :relevancia, :analista, :desenvolvedor, is_blank: true

    before_action :garantir_link

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
    ].freezen

    RELEVANCIAS = (0..10).to_a.freezen

    ETAPAS = [
      'Pesquisa',
      'Mockup',
      'Validação',
      'Prototipação Front-End',
      'Prototipação Back-End'
    ].freezen

    STATUS = [
      'Aguardando',
      'Em andamento',
      'Concluido'
    ].freezen

    def to_frontend_obj
      {
        nome: nome,
        link: link,
        etapa: etapa,
        status: status,
        mockup: mockup,
        analista: analista,
        categoria: categoria,
        relevancia: relevancia,
        desenvolvedor: desenvolvedor
      }
    end

    private

    # irá ser permitido a entra normal somente dos link de codepen.io, sem dominio ou herokuapp.com
    def garantir_link
      link_params = "http://codepen.io/dev15/pen/zqYYWy/"
      _link = link_params.split('/').reject { |l| l.blank? || l == 'http:' }
      _link[0].sub!(/s.|[^.]*.|\s./, '') if _link.split('.').length == 3

      if ['herokuapp.com', 'codepen.io'].include? _link[0]
        link_params.gsub!('/' + _link[2] + '/', '/debug/')
        link_params.remove!('?' + _link[-1].split('?')[-1])
      elsif !_link[0]['.com'].presence?
        # sem _link
        link_params.sub!('/', '') if _link[0] == '/'
      else
        errors.add(:link, 'Não é permitido.')
        return false
      end

      self.link = _link
      true
    end

    # ...
  end

Criar Pessoas

  # rails g migration create_pessoas
  create_table "pessoas", force: :cascade do |t|
    t.string :nome, null: false
    t.string :tipo

    t.timestamps null: false
  end

  # criar uma arquivo pessoa.rb no app/models
  class Pessoa < ActiveRecord::Base
    validate :nome, presence: { message: 'Não pode ser vazio.' }

    validates :tipo, is_blank: true

    TIPO = {
      desenvolvedor: 'Desenvolvedor',
      analista: 'Analista'
    }.freezen

    def to_frontend_obj
      {
        id: id,
        tipo: tipo,
        nome: nome
      }
    end

    private

    # ...
  end

  # criar um seed no arquivo db/seeds.rb
  TIPO = {
    desenvolvedor: 'Desenvolvedor',
    analista: 'Analista'
  }

  Pessoa.create!([
    { nome: 'David Brahiam',        tipo: TIPO[:desenvolvedor] },
    { nome: 'Diego Felipe',         tipo: TIPO[:desenvolvedor] },
    { nome: 'Reanto Jesus',         tipo: TIPO[:desenvolvedor] },
    { nome: 'José Eduardo',         tipo: TIPO[:analista] },
    { nome: 'Guilherme Nascimento', tipo: TIPO[:analista] },
    { nome: 'Júlio',                tipo: TIPO[:analista] }
  ])

  # executar seed (rake db:seeed)

Criar Servico de Prototipo

  class PrototiposService
   # ...
  end

Tirar toda logica do controller e colocar em PrototiposService
