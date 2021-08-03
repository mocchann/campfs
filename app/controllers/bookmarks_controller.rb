class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @field = Field.find(params[:field_id])
    bookmark = Bookmark.new(user_id: @current_user.id, field_id: @field.id)
    if bookmark.save
      respond_to do |format|
        format.html { redirect_to field }
        format.js
      end
    else
      render fields_path
    end
  end

  def destroy
    @field = Field.find(params[:field_id])
    Bookmark.find_by(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to @field }
      format.js
    end
  end
end
