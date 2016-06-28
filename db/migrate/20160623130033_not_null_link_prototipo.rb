#
class NotNullLinkPrototipo < ActiveRecord::Migration
  def up
    # change_column_null :prototipos, :link, true
  end

  def down
    change_column_null :prototipos, :link, false
  end
end
