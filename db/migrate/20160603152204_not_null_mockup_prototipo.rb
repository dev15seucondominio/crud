class NotNullMockupPrototipo < ActiveRecord::Migration
  def up
    change_column_null :prototipos, :mockup, true
  end

  def down
    change_column_null :prototipos, :mockup, false
  end
end
