def fibs(n)
  arr = [1,1]
  (n-2).times { arr[0], arr[1] = arr[1], arr[0] + arr[1] }
  arr[1]
end

def fibs_rec(n)
  n < 2 ? n : fibs_rec(n - 1) + fibs_rec(n - 2)
end

fibs_start = Time.now.to_f
puts "fibs: #{fibs(11)}"
fibs_end = Time.now.to_f
puts "fibs time: #{fibs_end - fibs_start}"

fibs_rec_start = Time.now.to_f
puts "fibs_rec: #{fibs_rec(11)}"
fibs_rec_end = Time.now.to_f
puts "fibs_rec time #{fibs_rec_end - fibs_rec_start}"