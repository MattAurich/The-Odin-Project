def stock_picker(price)
  maxprofit = 0
  buydate = 0
  selldate = 0

  price.length.times do |day|
    i = day
    while i < price.length do
      a = price[day+i].to_i - price[day].to_i
        if a > maxprofit
          maxprofit = a
          buydate = day
          selldate = day+i
        end
      i = i + 1
    end
  end
  return "Buy on day in index #{buydate} and sell on day in index #{selldate} for a profit of $#{maxprofit}"
end

puts stock_picker([17,3,6,9,15,8,6,1,10])
