class StaticPagesController < ApplicationController
  before_action :form_validate, only: :search

  def index
    # サメの商品コード
    @product_code = "IKEAのサメちゃん"
    @stock_data = helpers.get_stocks(10373589)
  end

  def search
    @product_code = params[:q_product]
    @stock_data = helpers.get_stocks(@product_code)
    render 'index'
  end

  private

    def form_validate
      # debugger
      unless params[:q_product] =~ /\A\d+\z/
        flash[:danger] = "不正な値です！半角数字で入力してね"
        redirect_to root_url
      end
    end
end
