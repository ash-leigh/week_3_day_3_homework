require_relative('./models/store')
require_relative('./models/pet')
require_relative('./db/sql_runner')

require('pry-byebug')

runner = SqlRunner.new({dbname: 'pet_stores', host: 'localhost'})

store_1 = Store.new({'name' => "Pet Shop", 'address' => "1 This Street, Doesnotexist, L0L 111", 'stock_type' => "Normal"}, runner)
store_1.save()

store_2 = Store.new({'name' => "Fancy Pet Shop", 'address' => "40 Nota Place, Lookonamap, HAH A56", 'stock_type' => "Exotic"}, runner)
store_2.save()

pet_1 = Pet.new({'name' => "Bob", 'type' => "Dog", 'store_id' => store_1.id}, runner)
pet_1.save()
pet_2 = Pet.new({'name' => "John", 'type' => "Cat", 'store_id' => store_1.id}, runner)
pet_2.save()
pet_3 = Pet.new({'name' => "Sherkhan", 'type' => "Tiger", 'store_id' => store_2.id}, runner)
pet_3.save()
pet_4 = Pet.new({'name' => "Dumbo", 'type' => "Elephant", 'store_id' => store_2.id}, runner)
pet_4.save()

binding.pry
nil