#
class PrototiposController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    status, resp = PrototipoService.index
    case status
    when :success
      respond_to do |f|
        f.html { render_layout }
        f.json { render json: resp }
      end
    when :errors
      render ::Resp.object_erros(resp)
    end
  def create
    status, resp = PrototipoService.create prototipo_params(params)
    case status
    when :success
      render json: resp
    when :errors
      render ::Resp.object_erros(resp)
    end
  end

  def update
    status, resp = PrototipoService.update prototipo_params(params)
    case status
    when :success
      render json: resp
    when :errors
      render ::Resp.object_erros(resp)
    end
  end

  def destroy
    status, resp = PrototipoService.destroy params
    case status
    when :success
      render json: resp
    when :errors
      render ::Resp.object_erros(resp)
    end
  end

  private

  def prototipo_params(params)
    params.require(:prototipo).permit(
      :nome, :relevancia, :status, :etapa, :tarefas, :analista, :link, :mockup,
      :desenvolvedor, :categoria
    )
  end
end
