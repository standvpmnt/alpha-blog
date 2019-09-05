class ArticlesController < ApplicationController

	before_action :set_article, only: [:edit, :update, :show, :destroy]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	def index
	@articles = Article.paginate(page: params[:page], per_page: 5)
	end

	def new
		@article = Article.new
	end

	def create
		#debugger ---- use ctrl+P to go to end of the debugging file
		@article = Article.new(article_params)
		@article.user = User.first
		#@article.save
		if @article.save
			flash[:success] = "Article was successfully created"
			redirect_to article_path(@article)
		else
			render :new
		end
		#redirect_to_article_path(@article)
		#render plain: params[:article].inspect
	end
	
	def edit
	end

	def update
		if @article.update(article_params)
			flash[:success] = "Article was updated successfully"
			redirect_to article_path(@article)
		else
			render :edit
		end
	end

	def show
	end

	def destroy
		@article.destroy
		flash[:danger] = "Article was successfuly destroyed"
		redirect_to articles_path
	end


	private
		def set_article
			@article = Article.find(params[:id])
		end

		def article_params
			params.require(:article).permit(:title, :description)
		end

		def require_same_user
			if current_user != @article.user
				flash[:danger] = "You can only edit or delete your own article"
				redirect_to root_path
			end
		end

end