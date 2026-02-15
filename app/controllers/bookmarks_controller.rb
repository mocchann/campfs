class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @field = Field.find(params[:field_id])
    bookmark = Bookmark.new(user_id: current_user.id, field_id: @field.id)
    if bookmark.save
      respond_to do |format|
        format.html { redirect_to @field }
        format.js
      end
    else
      redirect_to @field
    end
  end

  def destroy
    @field = Field.find(params[:field_id])
    current_user.bookmarks.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to @field }
      format.js
    end
  end
end
