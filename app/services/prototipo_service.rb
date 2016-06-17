#
class PrototipoService
  def self.index(params)
    prototipo = Prototipo.buscar(params)

    obj = {
      lista: prototipo.map do |pro|
        {
          id: pro.id,
          tarefas: pro.tarefas,
          status: pro.status,
          relevancia: pro.relevancia,
          categoria: pro.categoria,
          etapa: pro.etapa,
          analista: pro.analista
        }
      end
    }

    obj.merge!(obj_settings) if params[:with_settings]

    [:success, obj]
  end

  def self.comentarios_destroy(params)
    comentario = Comentario.where(id: params[:id]).first
    return [:errors, comentario] unless comentario.destroy

    [:success, comentario.to_frontend_obj]
  end

  def self.lista_show(prototipo)
    obj = { lista: prototipo.tap(&:to_frontend_obj) }
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
    prototipo = Prototipo.new(params)
    return [:errors, prototipo] unless prototipo.save

    comentarios = params[:comentarios]
    prototipo.comentarios.create(
      comentarios
    ) if comentarios.present? && comentarios.any?

    [:success, prototipo.to_frontend_obj]
  end

  def self.destroy(params)
    prototipo = Prototipo.where(id: params[:id]).first
    return :not_found unless prototipo.present?

    return [:errors, prototipo] unless prototipo.destroy

    [:success,  prototipo.to_frontend_obj]
  end

  def self.update(params)
    prototipo = Prototipo.find(params[:id])
    prototipo.assign_attributes(params.except(:comentarios))

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
      categorias: Prototipo::CATEGORIAS.clone.map do |categoria|
        { label: categoria, value: categoria }
      end,
      relevancias: Prototipo::RELEVANCIAS.map do |relevancia|
        { label: relevancia, value: relevancia }
      end,
      etapas: Prototipo::ETAPAS.clone.map do |etapa|
        { label: etapa, value: etapa }
      end,
      status: Prototipo::STATUS.clone.map do |status|
        { label: status, value: status }
      end,
      analistas: Pessoa.analistas.clone.map do |pessoa|
        { label: pessoa.nome, value: pessoa.nome }
      end,
      desenvolvedores: Pessoa.desenvolvedores.clone.map do |pessoa|
        { label: pessoa.nome, value: pessoa.nome }
      end
    }
  end
  private_class_method :obj_settings
end
