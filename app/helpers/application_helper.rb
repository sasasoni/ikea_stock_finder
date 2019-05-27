module ApplicationHelper
  require 'nokogiri'
  require 'open-uri'

  def ikea_product_url(product_code)
    "https://www.ikea.com/jp/ja/catalog/products/#{product_code}/"
  end

  def ikea_product_name(product_code)
    product_code == "10373589" ? "IKEAのサメちゃん" : product_code
  end

  def get_stocks(product_code)
    url = "https://www.ikea.com/jp/ja/iows/catalog/availability/#{product_code}"
    store_name_list = { "447" => "Tokyo-Bay", "448" => "港北", "887" => "新三郷", "486" => "神戸", "392" => "仙台", "509" => "長久手", "496" => "鶴浜", "189" => "福岡新宮", "359" => "立川" }
    stock_data = []

    begin
      xml = Nokogiri::XML(open(url).read)
    rescue
      return nil
    end
      store_nodes = xml.xpath('//availability/localStore')

    store_nodes.each do |store|
      store_code = store.attribute('buCode').text
      store_name = store_name_list[store_code]

      store.xpath('stock').each do |item|
        @stock_quantity = item.xpath('availableStock').text
        # if item.xpath('restockDate').any?
        #   restore_date = item.xpath('restockDate').text
        # else
        #   restore_date = "不明"
        # end
        @restore_date = item.xpath('restockDate').any? ? item.xpath('restockDate').text.to_datetime.strftime("%Y年%m月%d日") : "不明"
        # DateTime.parse("2019-02-04").strftime("%Y年%m月%d日")
      end

      store_data = {store_name: store_name, stock_quantity: @stock_quantity, restore_date: @restore_date}
      stock_data << store_data
    end
    stock_data
  end

end
