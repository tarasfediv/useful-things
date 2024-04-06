# Violation of the Open-Closed Principle in Ruby
class Logger
  def initialize(format, delivery)
    @format = format
    @delivery = delivery
  end

  def log(string)
    deliver format(string)
  end

  private

  def format(string)
    case @format
    when :raw
      string
    when :with_date
      "#{Time.now} #{string}"
    when :with_date_and_details
      "Log was creates at #{Time.now}, please check details #{string}"
    else
      raise NotImplementedError
    end
  end

  def deliver(text)
    case @delivery
    when :by_email
      Mailer.deliver(
        from: 'emergency@example.com',
        to: 'admin@example.com',
        subject: 'Logger report',
        body: text
      )
    when :by_sms
      client = Twilio::REST::Client.new('ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', 'your_auth_token')
      client.account.messages.create(
        from: '+15017250604',
        to: '+15558675309',
        body: text
      )
    when :to_stdout
      STDOUT.write(text)
    else
      raise NotImplementedError
    end
  end
end

logger = Logger.new(:raw, :by_sms)
logger.log('Emergency error! Please fix me!')

#-------------------------------------------------------------------------------
# Correct use of the Open-Closed Principle in Ruby
class Logger
  def initialize(formatter: DateDetailsFormatter.new, sender: LogWriter.new)
    @formatter = formatter
    @sender = sender
  end

  def log(string)
    @sender.deliver @formatter.format(string)
  end
end

class LogSms
  def initialize
    @account_sid = 'ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
    @auth_token = 'your_auth_token'
    @from = '+15017250604'
    @to = '+15558675309'
  end

  def deliver(text)
    client.account.messages.create(from: @from, to: @to, body: text)
  end

  private

  def client
    @client ||= Twilio::REST::Client.new(@account_sid, @auth_token)
  end
end

class LogMailer
  def initialize
    @from = 'emergency@example.com'
    @to = 'admin@example.com'
    @sublect = 'Logger report'
  end

  def deliver(text)
    Mailer.deliver(
      from: @from,
      to: @to,
      subject: @sublect,
      body: text
    )
  end
end

class LogWriter
  def deliver(log)
    STDOUT.write(text)
  end
end

class DateFormatter
  def format(string)
    "#{Time.now} #{string}"
  end
end

class DateDetailsFormatter
  def format(string)
    "Log was creates at #{Time.now}, please check details #{string}"
  end
end

class RawFormatter
  def format(string)
    string
  end
end

logger = Logger.new(formatter: RawFormatter.new, sender: LogSms.new)
logger.log('Emergency error! Please fix me!')