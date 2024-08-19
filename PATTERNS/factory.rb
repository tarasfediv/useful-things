# Simple Factory
class VehicleFactory
  def self.create_vehicle(type)
    case type
    when :car
      Car.new
    when :truck
      Truck.new
    when :motorcycle
      Motorcycle.new
    else
      raise "Unknown vehicle type"
    end
  end
end

class Car
  def drive
    "Driving a car!"
  end
end

vehicle = VehicleFactory.create_vehicle(:car)

# Factory Method
class VehicleFactory
  def create_vehicle
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end
end

class CarFactory < VehicleFactory
  def create_vehicle
    Car.new
  end
end

class TruckFactory < VehicleFactory
  def create_vehicle
    Truck.new
  end
end

class MotorcycleFactory < VehicleFactory
  def create_vehicle
    Motorcycle.new
  end
end

class Car
  def drive
    "Driving a car!"
  end
end

class Truck
  def drive
    "Driving a truck!"
  end
end

class Motorcycle
  def drive
    "Riding a motorcycle!"
  end
end

# Usage
factory = CarFactory.new
vehicle = factory.create_vehicle
puts vehicle.drive  # Output: "Driving a car!"

factory = TruckFactory.new
vehicle = factory.create_vehicle
puts vehicle.drive  # Output: "Driving a truck!"

# Abstract Factory
class VehicleFactory
  def create_vehicle
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end

  def create_engine
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end
end

class CarFactory < VehicleFactory
  def create_vehicle
    Car.new
  end

  def create_engine
    CarEngine.new
  end
end

class TruckFactory < VehicleFactory
  def create_vehicle
    Truck.new
  end

  def create_engine
    TruckEngine.new
  end
end

class Car
  def drive
    "Driving a car!"
  end
end

class CarEngine
  def start
    "Starting car engine!"
  end
end

class Truck
  def drive
    "Driving a truck!"
  end
end

class TruckEngine
  def start
    "Starting truck engine!"
  end
end

# Usage
factory = CarFactory.new
vehicle = factory.create_vehicle
engine = factory.create_engine

puts vehicle.drive  # Output: "Driving a car!"
puts engine.start   # Output: "Starting car engine!"

factory = TruckFactory.new
vehicle = factory.create_vehicle
engine = factory.create_engine

puts vehicle.drive  # Output: "Driving a truck!"
puts engine.start   # Output: "Starting truck engine!"
