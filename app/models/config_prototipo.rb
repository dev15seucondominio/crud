#
class ConfigPrototipo < ActiveRecord::Base
  validates :value, :label, uniqueness: { message: 'Tipo já existe.' }

  before_validation :garantir_value

  scope :ordem_criacao, -> { order(created_at: :desc) }
  scope :ordem_label, ->   { order(label: :asc) }

  scope :categoria, -> { where(type: 'Categoria') }
  scope :etapas, -> { where(type: 'Etapa') }
  scope :status, -> { where(type: 'Status') }

  def to_frontend_obj
    attrs = {
      id: id,
      type: type,
      label: label,
      value: value
    }

    attrs
  end

  private

  def garantir_value
    self.value = label.fileize
  end

  def self.attributes_protected_by_default
    # bug rails 4.1 que nulifica os types quando setados em params
    super - [inheritance_column]
  end
  private_class_method :attributes_protected_by_default
end
