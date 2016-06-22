#
class ConfigPrototipoService
  def self.create(params)
    attrs = params.except(:type)
    attrs[:type] = params[:type].capitalize

    configs_prototipos = ConfigPrototipo.new(attrs)
    return [:errors, configs_prototipos] unless configs_prototipos.save

    [:success, configs_prototipos.to_frontend_obj]
  end

  def self.destroy(params)
    configs_prototipos = ConfigPrototipo.where(id: params[:id]).first
    return :not_found unless configs_prototipos.present?

    return [:errors, configs_prototipos] unless configs_prototipos.destroy

    [:success, configs_prototipos.to_frontend_obj]
  end

  def self.update(params)
    attrs, = params.values_at(:label)

    configs_prototipos = ConfigPrototipo.where(id: params[:id]).first

    configs_prototipos.assign_attributes(attrs)
    return [:errors, configs_prototipos] unless configs_prototipos.save

    [:success, configs_prototipos.to_frontend_obj]
  end
end
