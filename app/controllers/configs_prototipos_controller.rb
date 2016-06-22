#
class ConfigsPrototiposController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    status, resp = ConfigPrototipoService.create config_params(params)
    # raise ", -------- #{resp}"
    # raise "#{resp}"
    case status
    when :success
      render json: resp
    when :errors
      render ::Resp.object_erros(resp)
    end
  end

  def update
    status, resp = ConfigPrototipoService.update config_params(params)

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
    status, resp = ConfigPrototipoService.destroy params
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

  def config_params(params)
    if params[:configs_prototipos].present?
      params.require(:configs_prototipos).permit(
        :id, :type, :value, :label
      )
    end
  end
end
