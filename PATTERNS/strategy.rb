#  Payment Processing System
class PaymentProcessor
  def initialize(strategy)
    @strategy = strategy
  end

  def process(amount)
    @strategy.pay(amount)
  end
end

class CreditCardPayment
  def pay(amount)
    # logic for credit card payment
  end
end

class PayPalPayment
  def pay(amount)
    # logic for PayPal payment
  end
end

# Usage
payment_processor = PaymentProcessor.new(CreditCardPayment.new)
payment_processor.process(100)
# -------------------------------
# Sorting Algorithms
# Strategy interface
class SortStrategy
  def sort(data)
    raise NotImplementedError, "This method should be overridden by subclasses"
  end
end

# Concrete Strategies
class BubbleSort < SortStrategy
  def sort(data)
    "Sorting data using Bubble Sort: #{data.sort}"
  end
end

class QuickSort < SortStrategy
  def sort(data)
    "Sorting data using Quick Sort: #{data.sort}"
  end
end

class MergeSort < SortStrategy
  def sort(data)
    "Sorting data using Merge Sort: #{data.sort}"
  end
end

# Context
class SortingContext
  def initialize(strategy)
    @strategy = strategy
  end

  def sort_data(data)
    @strategy.sort(data)
  end
end

# Usage
data = [5, 3, 8, 4, 2]

bubble_sort = BubbleSort.new
quick_sort = QuickSort.new

context = SortingContext.new(bubble_sort)
puts context.sort_data(data)  # Output: "Sorting data using Bubble Sort: [2, 3, 4, 5, 8]"

context = SortingContext.new(quick_sort)
puts context.sort_data(data)  # Output: "Sorting data using Quick Sort: [2, 3, 4, 5, 8]"

