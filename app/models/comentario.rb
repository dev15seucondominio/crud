#
class Comentario < ActiveRecord::Base
  belongs_to :prototipo, class_name: 'Prototipo'

  validates :nome, :mensagem, presence: { message: 'Não pode ser vazio.' }

  def to_frontend_obj
    {
      id: id,
      nome: nome,
      mensagem: mensagem
    }
  end
end
