class ArticlesController < ApplicationController
	def new
		@article = Article.new
	end
	def create
		@article = Article.new(article_params)
		@article.save
		redirect_to_articles_show(@article)
		#render plain: params[:article].inspect
	end

	private
		def article_params
			params.require(:article).permit(:title, :description)
		end

end