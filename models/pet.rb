class Pet

  attr_reader(:id, :name, :type, :store_id)

  def initialize(options, runner)
    @id = options['id']
    @name = options['name']
    @type = options['type']
    @store_id = options['store_id']
    @runner = runner
  end

  def self.all(runner)
    sql = "SELECT * FROM stores"
    pets_data = runner.run(sql)
    pets = pets_data.map {|pet| Pet.new(pet, runner)}
    return pets
  end

  def self.delete_by_id(id, runner)
    sql = "DELETE FROM pets WHERE id = #{id}"
    runner.run(sql)
  end

  def self.select_by_id(id, runner)
    sql = "SELECT * FROM pets WHERE id = '#{id}'"
    pet = runner.run(sql)
    return Pet.new(pet.first(), runner)
  end

  def save()
    sql = "INSERT INTO pets (name, type, store_id) VALUES ('#{@name}', '#{@type}', '#{@store_id}') RETURNING *"
    pet_data = @runner.run(sql)
    @id = pet_data.first['id'].to_i
  end

  def store()
    sql = "SELECT * FROM stores WHERE id = #{@store_id}"
    store_data = @runner.run(sql)
    store = Store.new(store_data.first, @runner)
    return store
  end

  def update (options)
    if (options['name'])
      @name = options['name']
    end
    if (options['type'])
      @type = options['type']
    end
    if (options['store_id'])
      @store_id = options['store_id']
    end
    
    pet_id = options['id'].to_i

    sql = "UPDATE pets SET 
      name = '#{ @name }', 
      type = '#{ @type }',
      store_id = '#{ @store_id }'
      WHERE id = #{ @id }"
      @runner.run(sql)
  end


end