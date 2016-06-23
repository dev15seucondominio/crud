#
class ComentarioService
  def self.create(params)
    comentario = Comentario.new(params)

    return [:errors, comentario] unless comentario.save

    [:success, comentario.to_frontend_obj]
  end

  def self.destroy(params)
    comentario = Comentario.where(id: params[:id]).first
    return [:errors, comentario] unless comentario.destroy

    [:success, comentario.to_frontend_obj]
  end
end
