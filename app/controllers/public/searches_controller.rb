class Public::SearchesController < ApplicationController
  before_action :authenticate_member!

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]

		if @model == 'member_name'
			@records = Member.search_for(@content, @method, 'name')
		elsif @model == 'member_nick_name'
			@records = Member.search_for(@content, @method, 'nick_name')
		elsif @model == 'book_title'
		  @records = Book.search_for(@content, @method, 'title')
		elsif @model == 'book_body'
		  @records = Book.search_for(@content, @method, 'body')
		elsif @model == 'genre'
			genres = Genre.search_for(@content, @method)
			@records = []
			genres.each do |genre|
				@records = @records + genre.books
			end
		end

	end
end
