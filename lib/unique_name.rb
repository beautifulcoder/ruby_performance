def get_unique_name
  carr = [('a'..'z'), ('A'..'Z')].map{ |x| x.to_a }.flatten
  (0..19).map{ carr.sample }.join
end
