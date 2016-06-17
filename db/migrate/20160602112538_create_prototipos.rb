class CreatePrototipos < ActiveRecord::Migration
  def change
    create_table :prototipos, force: :cascade do |t|
      t.text   :nome,         null: false
      t.string :tarefas,      null: false
      t.string :categoria,    null: false
      t.text   :mockup,       null: false
      t.text   :link,         null: false
      t.string :etapa,        null: false
      t.string :status,       null: false
      t.string :analista,     null: false
      t.string :desenvolvedor
      t.string :relevancia

      t.timestamps null: false
    end
  end
end
