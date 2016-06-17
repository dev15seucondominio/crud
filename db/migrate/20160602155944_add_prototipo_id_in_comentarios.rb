#
class AddPrototipoIdInComentarios < ActiveRecord::Migration
  def change
    add_column :comentarios, :prototipo_id, :integer, null: false
  end
end
