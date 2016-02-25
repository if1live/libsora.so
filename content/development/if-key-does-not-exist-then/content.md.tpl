title: 존재하지 않는 키로 테이블에 접근하면?
subtitle: 파이썬 vs 루비 vs C++
slug: if-key-does-not-exist-then
tags: python, ruby, cpp, hash, dictionary, map, table, key
date: 2016-02-25
author: if1live

존재하지 않은 키로 테이블에 접근했을때 각각의 언어는 어떤 식으로 행동할까?
올바르지 않은 인덱스로 리스트에 접근하면 각각의 언어는 어떤 식으로 행동할까?
파이썬, 루비, C++를 통해서 알아보자.

## 파이썬

파이썬은 C와 달리 음수 인덱스를 지원한다.
`-len(array) ~ len(array)-1` 까지는 올바른 인덱스이다.
음수 인덱스를 쓰면 배열을 뒤에서부터 접근할 수 있다.

만약 파이썬의 리스트에 허용 범위를 벗어난 인덱스로 접근하면 어떤 일이 벌어질까?
존재하지 않는 키로 파이썬의 사전에 접근하면 어떤 일이 벌어질까?

{{view:file=./key_not_exist.py}}

{{execute:cmd=python ./key_not_exist.py,attach_cmd=true}}

파이썬은 배열의 인덱스를 벗어나거나 존재하지 않는 키로 접근하면 예외가 발생한다.

## 루비

루비도 파이썬과 마찬가지로 음수 인덱스를 지원한다.
배열에서 허용하는 범위의 인덱스에서는 파이썬과 똑같이 행동한다.
그렇다면 허용되지 않은 범위의 인덱스에서는 어떻게 행동할까?
존재하지 않는 키로 해시에 접근하면 어떤 일이 벌어질까?

{{view:file=./key_not_exist.rb}}

{{execute:cmd=ruby ./key_not_exist.rb,attach_cmd=true}}

루비는 배열의 인덱스를 벗어나거나 존재하지 않는 키로 접근하면 nil을 얻는다.
[예제로 보는 Python과 Ruby의 문법 차이 - Multiple Assignment]({filename}multiple-assignment-python-and-ruby.md)의 연장선이다.
만약 루비에서도 파이썬처럼 배열의 인덱스를 벗어나거나 존재하지 않는 키로 접근할때 예외를 발생시키려면 어떻게 해야될까?
`#fetch`를 쓰면 된다.

* [Array#fetch](http://ruby-doc.org/core-2.3.0/Array.html#method-i-fetch)
* [Hash#fetch](http://ruby-doc.org/core-2.3.0/Hash.html#method-i-fetch)

{{view:file=./key_not_exist_alt.rb}}

{{execute:cmd=ruby ./key_not_exist_alt.rb,attach_cmd=true}}

## C++

파이썬에 Dictionary, 루비에 Hash가 있다면 C++에는 `std::map`이 있다.
존재하지 않는 키로`std::map`에 접근하면 어떤 일이 벌어질까?

{{view:file=./key_not_exist_bracket.cpp}}

{{execute:cmd=./key_not_exist_bracket,attach_cmd=true}}

**???**
map에는 2개를 넣어놨는데 한번 접근하고나니 map의 크기가 3이 되었다?

> 키가 존재하는지에 대해서 맵에 질의하는 방법은 세 가지가 있습니다.
> 명확한 방법은 다음과 같이 인덱스로서 키를 적용하는 것입니다.

> 이 경우의 단점은 키가 존재하지 않을 때 그 키를 삽입(insert)한다는 것입니다.
> 이때 값으로는 그 타입의 기본값이 주어집니다. 예를 들면, "spam"가 존재하지 않으면 0의 값으로 맵에 삽입됩니다.

> 맵에 질의를 하는 두 번째 방법은 맵과 관련된 find() 연산을 이용하는 것입니다
> (이 경우의 find()는 제네릭 알고리즘이 아닙니다).
> find()는 다음과 같이 키로 호출됩니다.

> 키가 존재하면 find()는 키/값 쌍을 가리키는 반복자를 반환합니다.
> 그렇지 않으면 end()를 반환합니다.

> 세 번째 방법은 맵과 관련된 count() 연산을 사용하여 맵에 질의합니다.
> count()는 맵 내에서 항목의 빈도수를 반환합니다.

> Essential C++, 3.7 맵(Map)의 사용, 스탠리 B. 립먼

[std::map::find](http://en.cppreference.com/w/cpp/container/map/find)를 이용하면 이런 식으로 구현할 수 있다.

{{view:file=./key_not_exist_find.cpp}}

{{execute:cmd=./key_not_exist_find,attach_cmd=true}}

[std::map::count](http://en.cppreference.com/w/cpp/container/map/count)를 이용하면 이런 식으로 구현할 수 있다.

{{view:file=./key_not_exist_count.cpp}}

{{execute:cmd=./key_not_exist_count,attach_cmd=true}}

* [std::map](http://en.cppreference.com/w/cpp/container/map)
* [std::map::operator[]](http://en.cppreference.com/w/cpp/container/map/operator_at)

## Summary

* 예외를 던진다
* null같은 값을 반환
* 적당히 기본값으로 채워준다.

존재하지 않는 키로 테이블에 접근하면 크게 3가지중 한가지로 행동할 것이다.
(이 범위에서 벗어나는 해괴한 행동이 또 있을까? 지금은 생각나지 않는다)

그리고 한가지 더, <s>그러니까 우리는 C++을 멀리하고....</s>

## 도전과제
이 글에서는 파이썬의 List, 루비의 Array에 대응되는 `std::vector`에 대해서는 다루지 않았다.
올바르지 않은 인덱스로 `std::vector`에 접근하면 어떤 일이 벌어질까?
vector에 인덱스로 접근하는 방법이 하나뿐일까?
