def stock_picker(prices)
  result = []
  max_profit = 0

  prices.each.with_index do |buy, buy_index|
    prices[buy_index + 1..-1].each.with_index do |sell, sell_index|
      profit = sell - buy
      if profit > max_profit
        max_profit = profit
        result = [buy_index, sell_index + buy_index + 1]
      end
    end
  end
  result
end

result = stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
puts result