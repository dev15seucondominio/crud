#
class PrototipoService
  def self.index(params)
    prototipo = Prototipo.buscar(params)

    obj = { lista: prototipo.map(&:slim_obj) }

    obj.merge!(obj_settings) if params[:with_settings]

    [:success, obj]
  end

  def self.comentarios_destroy(params)
    comentario = Comentario.where(id: params[:id]).first
    return [:errors, comentario] unless comentario.destroy

    [:success, comentario.to_frontend_obj]
  end

  def self.show(params)
    prototipo = Prototipo.where(id: params[:id]).first
    return :not_found if prototipo.blank?

    [:success, prototipo.to_frontend_obj]
  end

  def self.comentarios_create(params)
    comentario = Comentario.new(params)

    return [:errors, comentario] unless comentario.save

    [:success, comentario.to_frontend_obj]
  end

  def self.create(params)
    attrs = params.except(:categoria, :etapa, :status)
    attrs[:tarefas] = 'asdf'
    attrs.merge! change_types(params)

    prototipo = Prototipo.new(attrs)
    return [:errors, prototipo] unless prototipo.save

    comentarios = params[:comentarios]
    prototipo.comentarios.create(
      comentarios
    ) if comentarios.present? && comentarios.any?

    [:success, prototipo.slim_obj]
  end

  def self.destroy(params)
    prototipo = Prototipo.where(id: params[:id]).first
    return :not_found unless prototipo.present?

    return [:errors, prototipo] unless prototipo.destroy

    [:success,  prototipo.to_frontend_obj]
  end

  def self.update(params)
    attrs = params.except(:categoria, :etapa, :status)
    attrs.merge! change_types(params)

    prototipo = Prototipo.find(params[:id])
    prototipo.assign_attributes(attrs.except(:comentarios))

    return [:errors, prototipo] unless prototipo.save

    comentarios = params[:comentarios]
    prototipo.comentarios.create(
      comentarios.map
    ) if comentarios.present? && comentarios.any?

    [:success, prototipo.to_frontend_obj]
  end

  # private

  def self.obj_settings
    {
      categorias: ::Categoria.all.ordem_label.map(&:to_frontend_obj),
      etapas: ::Etapa.all.ordem_label.map(&:to_frontend_obj),
      status: ::Status.all.ordem_label.map(&:to_frontend_obj),
      relevancias: ::Prototipo::RELEVANCIAS.map do |relevancia|
        { label: relevancia, value: relevancia }
      end,
      analistas: ::Pessoa.analistas.clone.map do |pessoa|
        { label: pessoa.nome, value: pessoa.nome }
      end,
      desenvolvedores: ::Pessoa.desenvolvedores.clone.map do |pessoa|
        { label: pessoa.nome, value: pessoa.nome }
      end
    }
  end
  private_class_method :obj_settings

  def self.change_types(params)
    attrs = {}

    if params[:categoria].present?
      attrs[:categoria] = select_type(params[:categoria]).label
    end
    if params[:etapa].present?
      attrs[:etapa] = select_type(params[:etapa]).label
    end
    if params[:status].present?
      attrs[:status] = select_type(params[:status]).label
    end

    attrs
  end
  private_class_method :change_types

  def self.select_type(type_values)
    raise "#{type_values}"
    ::ConfigPrototipo.where(value: type_values).first
  end
  private_class_method :select_type
end
