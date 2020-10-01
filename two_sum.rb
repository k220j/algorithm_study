# https://leetcode.com/problems/two-sum/
# 리트코드 2개의 sum 이 target 을 만족하는가?

def two_sum(nums, target)
  hash_use(nums, target)
end


# nums 안에 존재하는 2개의 합이 target 을 만족하는 두개의 index를 찾아야 한다.
# 가장 쉽게 푸는 방법은 brute_force로 하나하나 다 뒤지는게 가장 쉽다.
# n^2 으로 일단 풀어보자.
def brute_force(nums, target)
  size = nums.size
  nums.each_with_index  do |f_val, idx|
    if idx == size-1
      raise NoMemoryError.new('인덱스를 넘어버렸습니다.')
    end

    nums[idx+1 .. nums.length].each_with_index do |s_val, idx_2|
      if (f_val + s_val) == target
        return [idx, idx_2 + idx +1]
      end
    end
  end
end


# hash 를 사용해서 처음에 hash 안에 idx 별로 저장을 해놓고
# 값이 있으면 idx 를 리턴하고 없으면 다음 array 를 순회한다.
def hash_use(nums, target)
  num_hash = {}
  nums.each_with_index do |num, idx|
    num_hash[num] = idx
  end

  nums.each_with_index do |val, idx|
    find_val = target- val
    if !num_hash[find_val].nil? && num_hash[find_val] != idx
      return [idx, num_hash[find_val]]
    end
  end

  raise StandardError.new('값이 없습니다.')
end


# hash를 처음에 초기화를 해놓지 않는다.
# 순회하면서 있으면 데이터를 넣어놓고 없으면 다음을 진행한다.
def hash_use_first(nums, target)
  num_hash = {}
  nums.each_with_index do |val, idx|
    find_val = target- val
    if !num_hash[find_val].nil? && num_hash[find_val] != idx
      return [idx, num_hash[find_val]]
    end
    num_hash[val] = idx
  end

  raise StandardError.new('값이 없습니다.')
end