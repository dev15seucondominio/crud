#
class HomeController < ApplicationController
  def index
    respond_to do |f|
      f.html { render_layout }
    end
  end
end
