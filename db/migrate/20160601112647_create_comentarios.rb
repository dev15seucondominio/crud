#
class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios, force: :cascade do |t|
      t.string :nome,          null: false
      t.text :mensagem,        null: false

      t.timestamps null: false
    end
  end
end
