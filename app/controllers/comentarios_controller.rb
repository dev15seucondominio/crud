#
class ComentariosController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    status, resp = ComentarioService.create comentario_params(params)
    case status
    when :success
      render json: resp
    when :errors
      render ::Resp.object_erros(resp)
    end
  end

  def destroy
    status, resp = ComentarioService.destroy comentario_params(params)
    case status
    when :success
      render json: resp
    when :errors
      render ::Resp.object_erros(resp)
    end
  end

  private

  def comentario_params(params)
    if params[:comentarios].present?
      params.require(:comentarios).permit(
        :id, :mensagem, :nome, :prototipo_id
      )
    end
  end
end
