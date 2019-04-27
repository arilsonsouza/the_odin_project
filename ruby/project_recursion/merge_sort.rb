def merge(a, b)
  c = []
  while a != [] && b != []
    if a[0] < b[0]
      c << a.shift
    else
      c << b.shift
    end
  end

  while a != []
    c << a.shift
  end
  
  while b != []
    c << b.shift
  end

  c
end

def merge_sort(arr)
  n = arr.length - 1
  return arr if n == 0

  left_side = merge_sort(arr[0..n/2])
  right_side = merge_sort(arr[n/2+1..-1])

  merge(left_side, right_side)
end

arr = Array.new(rand(5..10)) { rand(1...10000)}

puts "original array => #{ arr }"
puts "sorted array   => #{merge_sort(arr)}"