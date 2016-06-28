#
class PrototiposController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    respond_to do |f|
      f.html { render_layout }
      f.json do
        status, resp = PrototipoService.index(params)
        case status
        when :success
          render json: resp
        when :errors
          render ::Resp.object_erros(resp)
        end
      end
    end
  end

  def show
    status, resp = PrototipoService.show(params)
    case status
    when :success
      render json: resp
    when :not_found
      render ::Resp.not_found
    end
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
    when :not_found
      render ::Resp.not_found
    when :errors
      render ::Resp.object_erros(resp)
    end
  end

  def destroy
    status, resp = PrototipoService.destroy params
    case status
    when :success
      render json: resp
    when :not_found
      render ::Resp.not_found
    when :errors
      render ::Resp.object_erros(resp)
    end
  end

  private

  def prototipo_params(params)
    params[:prototipos].present?
    params.require(:prototipos).permit(
      :id, :nome, :relevancia, :analista, :mockup, :desenvolvedor,
      :link,
      status: :value, etapa: :value, categoria: :value, tarefas: :value
    )
    # raise params[:comentarios_attributes]
  end
end
