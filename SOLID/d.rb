# Violation of the Dependency Inversion Principle in Ruby
class Printer
  def initialize(data)
    @data = data
  end

  def print_pdf
    PdfFormatter.new.format(@data)
  end

  def print_html
    HtmlFormatter.new.format(@data)
  end
end

class PdfFormatter
  def format(data)
    # format data to Pdf logic
  end
end

class HtmlFormatter
  def format(data)
    # format data to Html logic
  end
end

# ------------------------------------------------------------------------------
#Correct use of the Dependency Inversion Principle in Ruby
class Printer
  def initialize(data)
    @data = data
  end

  def print(formatter: PdfFormatter.new)
    formatter.format(@data)
  end
end

class PdfFormatter
  def format(data)
    # format data to Pdf logic
  end
end

class HtmlFormatter
  def format(data)
    # format data to Html logic
  end
end
# 
# 
# Високорівневі модулі не повинні залежати від низькорівневих. Обидва повинні залежати від абстракцій.
# Поганий приклад:
class Notification
  def send_email(user)
    # Логіка надсилання email
  end
end

class User
  def notify
    Notification.new.send_email(self)
  end
end

# Хороший приклад:
class Notification
  def notify(user, notifier)
    notifier.send(user)
  end
end

class EmailNotifier
  def self.send(user)
    # Логіка надсилання email
  end
end

class SMSNotifier
  def self.send(user)
    # Логіка надсилання SMS
  end
end

# Використання
notification = Notification.new
notification.notify(user, EmailNotifier)
notification.notify(user, SMSNotifier)
