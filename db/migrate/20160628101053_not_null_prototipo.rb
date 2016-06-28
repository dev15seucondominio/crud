#
class NotNullPrototipo < ActiveRecord::Migration
  def change
    change_column_null :prototipos, :link, :text, true
    change_column_null :prototipos, :tarefas, :string, true
    change_column_null :prototipos, :desenvolvedor, :string, true
  end
end
