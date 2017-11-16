class SupportArticlesController < ApplicationController

    layout 'support'

    def index
        @articles = SupportArticle.all.page(params[:page]).per(20)
    end

    def show
        @articles = SupportArticle.all.order(created_at: :desc)
        @article  = SupportArticle.find_by! slug: params[:id]
    end

end
