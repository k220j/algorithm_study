"dogcatcatdog"
'aabb'

내 풀이 방법
def word_pattern(pattern, s)
  pattern_arr =  pattern.split('')
  s_arr = s.split(' ')

  if pattern_arr.size != s_arr.size
    return false
  end

  pattern_hash = {}
  word_hash = {}

  pattern_arr.each_with_index do |p, idx|
    word  = s_arr[idx]
    if pattern_hash[p].nil?
      pattern_hash[p] = word
      word_hash[word] = p
    else
      return false if pattern_hash[p] != word
    end
  end

  return pattern_hash.size == word_hash.size
end



# 공간복잡도 M(Pattern, S 의 단어 개수만큼)
# 시간복잡도 N(S나  Pattern 에 있는 단어 개수만큼)
def word_pattern_sol(pattern, s)
  pattern_arr =  pattern.split('')
  s_arr = s.split(' ').map(&:upcase)

  if pattern_arr.size != s_arr.size
    return false
  end

  map_index = {}

  pattern_arr.each_with_index do |p, idx|
    word  = s_arr[idx]
    if map_index[p].nil?
      map_index[p] = idx
    end

    if map_index[word].nil?
      map_index[word] = idx
    end

    if map_index[word] != map_index[p]
      return false
    end

  end

  return true
end

#
#
# 1. 처음 접근은 hash 로 접근했고
# 2. 생각을 하다보니 s, pattern 이 달라도 겹치는 케이스가 있다고 판단(순서문제로 인해서)
# 그래서 2중 해시로 접근했다.
# ex) {a: dog}, {dog: a} , {cat, b}, {b: cat}
# 이 방식은 해시를 2개를 써야한다.
#
# 3. 해설 중 단 하나의 hashmap 으로 접근하는 방법이 있다.
# 바로 하나의 해시맵에 패턴과 단어를 각각으로 분리해서 각각 키로 가지고 이를 인덱스로 관리하는 기법이다.
# 두개의 키들 (패턴값, 단어값) 의 index 가 같으면 같은 거고 다르면 패턴이 맞지 않는 거겠지.
# 여기서 또 문제가 발생! 단어가 반드시 여러개의 문자열로 오지는 않는다. 패턴의 값과 겹치는 단어가 있어서( pattern : 'abc' s: 'abc')
# s는 모두 대문자 변환 처리함
#
#
# WRONG CASE
#
# 1. s, pattern 의 사이즈가 다를 수 있다. => 서로 사이즈가 다르면 fasle 를 리턴함
# 2. s, pattern 이 모두 split 했을때 같은 경우 발생