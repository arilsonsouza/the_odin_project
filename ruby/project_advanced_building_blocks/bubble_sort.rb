def bubble_sort(array)
  n = array.length - 2
  loop do
    sorted = true
    for j in (0..n) do
      if array[j] > array[j + 1]
        array[j], array[j + 1] = array[j + 1], array[j]
        sorted = false
      end
    end
    break if sorted
    n -= 1
  end
  array
end

def bubble_sort_by(array)
  n = array.length - 2
  loop do
    sorted = true
    for j in (0..n) do
      if yield(array[j], array[j + 1]) > 0
        array[j], array[j + 1] = array[j + 1], array[j]
        sorted = false
      end
    end
    break if sorted
    n -= 1
  end
  puts array
end

for i in (0..5) do
  array = Array.new(rand(5..10)) { rand(1...100)}
  puts "bubble_sort(#{array}) = #{ bubble_sort(array) }"
  puts "-" * 80
end

bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end