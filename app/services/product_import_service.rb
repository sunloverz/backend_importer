class ProductImportService
  attr_reader :filename

  def initialize(filename)
    @filename = File.join Rails.root, filename
  end

  def call
    count = 0
    products = []
    CSV.foreach(filename, headers: true) do |row|
      count += 1
      products << attributes(row) unless has_empty_field?(row) 
      if count%100 == 0
        Product.insert_all(products, unique_by: :index_products_on_brand_and_code)
        products = []
        count = 0
      end 
    end
  end

private 

  def attributes(row)
    product = {
      brand: row['Производитель'] || row['Бренд'],
      code: row['Артикул'] || row['Номер'],
      stock: row['Количество'] || row['Кол-во'],
      name: row['Наименование'] || row['НаименованиеТовара'],
      cost: row['Цена']
    }
    product[:cost] = product[:cost].to_f if product[:cost]
    product[:stock] = product[:stock].delete('>').to_i if product[:stock]
    product
  end

  def has_empty_field?(row)
    product = attributes(row)
    product.each do |_, value|
      return true if value.to_s.empty?
    end
    false
  end
end