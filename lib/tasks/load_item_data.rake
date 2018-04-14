desc 'Loads data from lib/data/items.csv file to items table'

task :load_item_data => :environment do
    MyLogger.log('Starting to load the item data')
    Item.import!
    MyLogger.log('Done loading the item data')
end