class CreateConfigPrototipos < ActiveRecord::Migration
  def change
    create_table :config_prototipos do |t|
      t.string :type, null: false
      t.string :label, null: false
      t.string :value, null: false

      t.timestamps null: false
    end
  end
end
