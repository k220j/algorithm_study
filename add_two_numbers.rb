# Definition for singly-linked list.
class ListNode
    attr_accessor :val, :next
    def initialize(val = 0, _next = nil)
        @val = val
        @next = _next
    end
end


# https://leetcode.com/problems/add-two-numbers/submissions/

# linked list 의 순서보장 없이 실제 계산기를 구하는 것.

def solve(l1, l2)
  dummy = ListNode.new(0)
  curr = dummy
  carry = 0
  while(!l1.nil? || !l2.nil?)
    v1 = l1.nil? ? 0 : l1.val
    v2 = l2.nil? ? 0 : l2.val

    val = v1 + v2 + carry
    carry = val / 10

    curr.next = ListNode.new(val % 10)

    curr= curr.next
    l1= l1.next unless l1.nil?
    l2= l2.next unless l2.nil?
  end

  if carry >0
    curr.next = ListNode.new(carry)
  end

  return dummy.next
end


1. 풀이 전략
1. 역순으로 들어오는 노드들을 배열로 만들어서 역정렬
2. 해당 배열들을 string 으로 변환해서 숫자로 변환
3. 더하기
4. 다시 string 으로 변환해서
5. split 해서 하나씩 숫자로 변환

def add_two_numbers(l1, l2)
  num1 = convert_arr_to_number(make_arr(l1))
  num2 = convert_arr_to_number(make_arr(l2))
  target_arr = convert_number_to_arr(num1 + num2)

  arr_to_list(target_arr)

  # return f_node
end

def make_arr(l)
  arr = []
  while(true)
    if l.next.nil?
      return arr
    end
    l = l.next
  end

  arr
end


# 숫자를 array 로 만들기
# 521
# convert_number_to_arr(521)
def convert_number_to_arr(num)
  arr = []
  while(true)
    mok =  num/10
    val = num % 10
    if mok == 0
      arr.push(val % 10)
      break
    else
      num = mok
      arr.push(val % 10)
    end
  end

  return arr
end

def convert_arr_to_number(arr)
  num = 0
  arr.each_with_index do  |val, idx|
    num += val * (10 ** idx)
  end

  return num
end

def arr_to_list(arr)
  f = ListNode.new(arr[0], nil)
  node_arr = [f]
  arr[1..arr.size].each do |val|
    new_node = ListNode.new(val, nil)
    last_node = node_arr.last
    last_node.next= new_node
    node_arr.push(new_node)
  end

  f
end