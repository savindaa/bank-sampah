class V1::ArticlesController < ApplicationController
    before_action :authenticate_admin, only: [:create, :update, :destroy]
    before_action :set_article, except: :create

    def create
        @article = Article.create!(article_params)
        json_response(@article, :create)
    end

    def show
        json_response(@article)
    end

    def update
        @article.update(article_params)
        json_response(@article)
    end

    def destroy
        @article.destroy
        head 204
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :body, :author, :source)
    end
end