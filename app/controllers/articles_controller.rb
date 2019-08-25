class ArticlesController < ApplicationController

def index
	@articles = Article.all
end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		#@article.save
		if @article.save
			flash[:notice] = "Article was successfully created"
			redirect_to article_path(@article)
		else
			render :new
		end
		#redirect_to_article_path(@article)
		#render plain: params[:article].inspect
	end
	
	def show
		@article = Article.find(params[:id])
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:notice] = "Article was updated successfully"
			redirect_to article_path(@article)
		else
			render :edit
		end
	end

	private
		def article_params
			params.require(:article).permit(:title, :description)
		end

end