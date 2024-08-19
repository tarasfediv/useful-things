# Basic Singleton Implementation
require 'singleton'

class Logger
  include Singleton

  def initialize
    @log = []
  end

  def log(message)
    @log << message
    puts "Log: #{message}"
  end

  def show_log
    @log
  end
end

# Usage
logger1 = Logger.instance
logger2 = Logger.instance

logger1.log("This is the first log message.")
logger2.log("This is the second log message.")

puts logger1.show_log.inspect # Output: ["This is the first log message.", "This is the second log message."]
puts logger1.object_id == logger2.object_id

# --------------------------------------------------------------
# Manual Singleton Implementation
class ConfigManager
  @instance = nil

  private_class_method :new

  def self.instance
    @instance ||= new
  end

  def initialize
    @settings = {}
  end

  def set(key, value)
    @settings[key] = value
  end

  def get(key)
    @settings[key]
  end
end

# Usage
config1 = ConfigManager.instance
config2 = ConfigManager.instance

config1.set('theme', 'dark')
puts config2.get('theme')
puts config1.object_id == config2.object_id
# ---------------------------------------------------------
# Singleton for a Database Connection
class DatabaseConnection
  @instance = nil

  private_class_method :new

  def self.instance
    @instance ||= new
  end

  def connect
    @connection = "Database connection established"
  end

  def connection
    @connection
  end
end

# Usage
db1 = DatabaseConnection.instance
db2 = DatabaseConnection.instance

db1.connect
puts db2.connection  # Output: "Database connection established"
puts db1.object_id == db2.object_id
