class SupportArticlesController < ApplicationController

    layout 'store'

    def index
        @articles = SupportArticle.all
    end

    def show
        @article = SupportArticle.find_by! slug: params[:id]
    end

end
