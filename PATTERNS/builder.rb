# Building a House
# Product
class House
  attr_accessor :rooms, :garage, :swimming_pool, :garden

  def initialize
    @rooms = 0
    @garage = false
    @swimming_pool = false
    @garden = false
  end

  def show
    puts "House with #{@rooms} rooms, " \
         "#{@garage ? 'a garage' : 'no garage'}, " \
         "#{@swimming_pool ? 'a swimming pool' : 'no swimming pool'}, " \
         "#{@garden ? 'a garden' : 'no garden'}."
  end
end

# Builder Interface
class HouseBuilder
  def initialize
    @house = House.new
  end

  def add_rooms(number)
    @house.rooms = number
    self
  end

  def add_garage
    @house.garage = true
    self
  end

  def add_swimming_pool
    @house.swimming_pool = true
    self
  end

  def add_garden
    @house.garden = true
    self
  end

  def build
    @house
  end
end

# Director (optional)
class HouseDirector
  def initialize(builder)
    @builder = builder
  end

  def construct_luxury_house
    @builder.add_rooms(5).add_garage.add_swimming_pool.add_garden.build
  end

  def construct_basic_house
    @builder.add_rooms(2).build
  end
end

# Usage
builder = HouseBuilder.new
director = HouseDirector.new(builder)

luxury_house = director.construct_luxury_house
luxury_house.show
# Output: House with 5 rooms, a garage, a swimming pool, a garden.

basic_house = director.construct_basic_house
basic_house.show
# Output: House with 2 rooms, no garage, no swimming pool, no garden.
# ------------------------------------------------------
# Building a Pizza
# Product
class Pizza
  attr_accessor :dough, :sauce, :toppings

  def initialize
    @toppings = []
  end

  def show
    puts "Pizza with #{@dough} dough, #{@sauce} sauce, and toppings: #{@toppings.join(', ')}."
  end
end

# Builder Interface
class PizzaBuilder
  def initialize
    @pizza = Pizza.new
  end

  def add_dough(dough)
    @pizza.dough = dough
    self
  end

  def add_sauce(sauce)
    @pizza.sauce = sauce
    self
  end

  def add_topping(topping)
    @pizza.toppings << topping
    self
  end

  def build
    @pizza
  end
end

# Usage
builder = PizzaBuilder.new

pizza = builder.add_dough('thin crust')
              .add_sauce('tomato')
              .add_topping('cheese')
              .add_topping('pepperoni')
              .build

pizza.show
# Output: Pizza with thin crust dough, tomato sauce, and toppings: cheese, pepperoni.

