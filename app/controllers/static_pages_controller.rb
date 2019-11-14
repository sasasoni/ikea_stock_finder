class StaticPagesController < ApplicationController
  before_action :form_validate, only: :search

  def home
    # サメの商品コード
    @product_code = "10373589"
    @stock_data = helpers.get_stocks(@product_code)
    if @stock_data.nil?
      render 'error'
    end
  end

  def search
    @product_code = params[:q_product]
    @stock_data = helpers.get_stocks(@product_code)
    # debugger
    if @stock_data.nil?
      flash[:danger] = "商品が見つかりませんでした。。。"
      redirect_to root_url
    else
      render 'home'
    end
  end

  private

    def form_validate
      # debugger
      unless params[:q_product] =~ /\AS?\d+\z/
        flash[:danger] = "不正な値です！半角英数字で入力してね"
        redirect_to root_url
      end
    end
end
