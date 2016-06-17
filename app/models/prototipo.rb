#
class Prototipo < ActiveRecord::Base
  before_validation :garantir_link

  validates :nome, :categoria, :etapa, :tarefas, :desenvolvedor,
            :status, :analista, presence: { message: 'Não pode ser vazio.' }
  # validate :category, :etap, :stats, :relevan, :analist, :taref, :lin, :mo,
  #          :dev, is_blank: false

  has_many :comentarios, class_name: 'Comentario', foreign_key: :prototipo_id

  scope :buscar, lambda { |params|
    scope = all
    unless params[:q].blank?
      # exemplo OR
      q = []
      params_arr = []

      unless params[:q].sem_numeros.blank?
        q << ['(nome LIKE ? )', '(analista LIKE ?)', '(desenvolvedor LIKE ?)',
              '(tarefas LIKE ?)']
        params_arr << "%#{params[:q].sem_numeros}%"
        params_arr << "%#{params[:q].sem_numeros}%"
        params_arr << "%#{params[:q].sem_numeros}%"
        params_arr << "%#{params[:q].sem_numeros}%"
      end

      unless params[:q].somente_numeros.blank?
        q << '(tarefas LIKE ?)'
        params_arr << "%#{params[:q].somente_numeros.to_i}%"
      end
      scope = scope.where(*q.join(' OR '), *params_arr.flatten)
    end

    unless params[:q].present?
      q = []
      params_arr = []

      if params[:analista].present?
        q << '(analista LIKE ?)'
        params_arr << "%#{params[:analista]}%"
      end

      if params[:relevancia].present?
        q << '(relevancia LIKE ?)'
        params_arr << "%#{params[:relevancia]}%"
      end

      if params[:categoria].present?
        q << '(categoria LIKE ?)'
        params_arr << "%#{params[:categoria]}%"
      end

      if params[:status].present?
        q << '(status LIKE ?)'
        params_arr << "%#{params[:status]}%"
      end

      if params[:etapa].present?
        q << '(etapa LIKE ?)'
        params_arr << "%#{params[:etapa]}%"
      end

      if params[:desenvolvedor].present?
        q << '(desenvolvedor LIKE ?)'
        params_arr << "%#{params[:desenvolvedor]}%"
      end
      scope = scope.where(*q.join(' AND '), *params_arr.flatten)
    end
    scope
  }

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

  RELEVANCIAS = (0..10).to_a.freeze

  def to_frontend_obj
    attrs = {
      id: id,
      nome: nome,
      link: link,
      etapa: etapa,
      status: status,
      mockup: mockup,
      tarefas: tarefas,
      analista: analista,
      categoria: categoria,
      relevancia: relevancia,
      desenvolvedor: desenvolvedor,
      comentarios: comentarios.map(&:to_frontend_obj)
    }
  end

  private

  # # ira ser permitido a entra normal somente dos link de codepen.io,
  # # sem dominio ou herokuapp.com
  def garantir_link
    if link.present?
      link_params = link
      _link = link_params.split('/').reject { |l| l.blank? || l == 'http:' }
      _link[0].sub!(/s.|[^.]*.|\s./, '') if _link[0].split('.').length == 3
      if ['herokuapp.com', 'codepen.io'].include? _link[0]
        link_params.gsub!('/' + _link[2] + '/', '/debug/')
        link_params.remove!('?' + _link[-1].split('?')[-1])
      elsif !_link[0]['.com'].try(:presence?)
        # sem link
        link_params.sub!('/', '') if _link[0] == '/'
      else
        errors.add(:link, 'Não é permitido.')
        return false
      end
      self.link = link_params
    end
  end
end
