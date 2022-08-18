class Admin::HomesController < ApplicationController

  def top
    redirect_to admin_books_path
  end

end
