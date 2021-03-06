class ChaptersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_book

  def index
    redirect_to @book
  end
  
  def show
    @chapter = find_chapter(params[:id])
    @previous_chapter = find_chapter(params[:id].to_i-1)
    @next_chapter = find_chapter(params[:id].to_i+1)
  end
  
  private
  
  def find_book
    @book = Book.find_by_permalink(params[:book_id])
  end

  def find_chapter(permalink)
    @book.chapters.find_by(permalink: permalink)
  end
end
