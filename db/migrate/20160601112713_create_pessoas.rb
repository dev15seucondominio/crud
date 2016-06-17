#
class CreatePessoas < ActiveRecord::Migration
  def change
    create_table "pessoas", force: :cascade do |t|
      t.string :nome, null: false
      t.string :tipo

      t.timestamps null: false
    end
  end
end
