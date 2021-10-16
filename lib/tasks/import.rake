require 'csv'

namespace :import do 

  desc 'Import products from csv'
  task products: :environment do
    Product.delete_all
    ProductImportService.new('price_1.csv').call
  end
end