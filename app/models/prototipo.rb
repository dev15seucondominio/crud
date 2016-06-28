#
class Prototipo < ActiveRecord::Base
  before_validation :garantir_link

  validates :nome, :categoria, :etapa, :status, :analista, presence:
            { message: 'Não pode ser vazio.' }

  has_many :comentarios, class_name: 'Comentario', foreign_key: :prototipo_id,
                         dependent: :destroy

  accepts_nested_attributes_for :comentarios

  scope :buscar, lambda { |params|
    scoped = all

    if params[:q].blank?
      scoped = scoped.busca_avancada(params)
    else
      scoped = scoped.busca_simples(params[:q])
    end

    scoped
  }

  scope :busca_avancada, lambda { |params|
    scoped = all

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
      status_label = ::ConfigPrototipo.where(value: params[:categoria]).first.label

      q << '(categoria LIKE ?)'
      params_arr << "%#{status_label}%"
    end

    if params[:status].present?
      status_label = ::ConfigPrototipo.where(value: params[:status]).first.label

      q << '(status LIKE ?)'
      params_arr << "%#{status_label}%"
    end

    if params[:etapa].present?
      status_label = ::ConfigPrototipo.where(value: params[:etapa]).first.label

      q << '(etapa LIKE ?)'
      params_arr << "%#{status_label}%"
    end

    if params[:desenvolvedor].present?
      q << '(desenvolvedor LIKE ?)'
      params_arr << "%#{params[:desenvolvedor]}%"
    end
    scoped = scoped.where(*q.join(' AND '), *params_arr.flatten)

    scoped
  }

  scope :busca_simples, lambda { |q|
    scoped = all

    query = []
    params_arr = []

    unless q.sem_numeros.blank?
      query << ['(nome LIKE ? )', '(analista LIKE ?)', '(desenvolvedor LIKE ?)',
                '(tarefas LIKE ?)']
      params_arr << "%#{q.sem_numeros}%"
      params_arr << "%#{q.sem_numeros}%"
      params_arr << "%#{q.sem_numeros}%"
      params_arr << "%#{q.sem_numeros}%"
    end

    unless q.somente_numeros.blank?
      query << '(tarefas LIKE ?)'
      params_arr << "%#{q.somente_numeros.to_i}%"
    end

    scoped.where(*query.join(' OR '), *params_arr.flatten)
  }

  RELEVANCIAS = (0..10).to_a.freeze

  serialize :tarefas, Array

  def slim_obj
    attrs = {
      id: id,
      tarefas: tarefas,
      analista: analista,
      relevancia: relevancia,
      etapa: { label: etapa, value: etapa.fileize },
      status: { label: status, value: status.fileize },
      categoria: { label: categoria, value: categoria.fileize }
    }
    attrs
  end

  def to_frontend_obj
    attrs = {
      mockup: mockup,
      nome: nome,
      link: link,
      desenvolvedor: desenvolvedor
    }.merge slim_obj
    attrs[:comentarios] = comentarios.map(&:to_frontend_obj)

    attrs
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
