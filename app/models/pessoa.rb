#
class Pessoa < ActiveRecord::Base
  validates :nome, presence: { message: 'Não pode ser vazio.' }

  TIPO = {
    desenvolvedor: 'Desenvolvedor',
    analista: 'Analista'
  }.freeze

  # validates :type, is_blank: true
  scope :analistas, -> { where(tipo: TIPO[:analista]) }
  scope :desenvolvedores, -> { where(tipo: TIPO[:desenvolvedor]) }

  def to_frontend_obj
    {
      id: id,
      tipo: tipo,
      nome: nome
    }
  end
end
