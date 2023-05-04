---
title: KMP 算法小记
updated: 2023-04-28 08:40:48Z
created: 2023-04-28 08:40:40Z
---

KMP 算法 主要是用来从一个主串``s``中查找子串``p``的位置

要从 ``s`` 中找 ``p`` 首先想到的就是暴力搜索
暴力搜索示例:
s = "abcdabce"
p = "bce"
* step 1: 
```
abcdabce
bce
```
a == b ? 不相等, 则next 
* setp 2:  
```
abcdabce
 bce
```
b==b ? c==c ? d==e?  显然 d!=e ,  next
* step 3:
```
abcdabce
  bce
```
c == b ? 不相等 , next ......
直至到最后找出结果

这么做的话会发现比较浪费, 在 ``setp 2``中, ``p``中的 ``b``与``c`` 都比较过了,能不能想办法不再比较 ``b`` 与``c`` 了, 这个办法就是 __kmp__



下面给出 swift 版本代码 :

```swift
class Solution {
    
    var next: [Int] = [];
    
    func kmpSearch(_ s: String ,_ p: String) -> Int {
        next = getNext(p);
        let sLen = s.count;
        let pLen = p.count;
        let s = s.cString(using: .utf8);
        let p = p.cString(using: .utf8);
        
        var i = 0;
        var j = 0;
        
        while (i < sLen && j < pLen ) {
            // 当 p 与 s 第一个字符都不匹配的时候 (j == -1)
            // 或当 p 与 s 当前字符匹配成功 (s?[i] == p?[j])
            // 则进行下一个字符匹配
            if j == -1 || s?[i] == p?[j] {
                i += 1;
                j += 1;
            } else {
                // 如果 当前字符匹配失败（即S[i] != P[j]），则令 i 不变，j = next[j]
                // next[j] 即为 j 所对应的 next 值
                j = next[j];
            }
        }
        if j == pLen {
            return i - j;
        }
        return -1;
    }
    
    func getNext(_ p: String ) -> [Int] {
        let len = p.count;
        let p = p.cString(using: .utf8);
        var next = Array.init(repeating: 0, count: len);
        
        next[0] = -1;
        var k = -1;
        var j = 0;
        while j < len - 1 {
            //p[k]表示前缀，p[j]表示后缀
            if (k == -1 || p?[j] == p?[k]) {
                j += 1;
                k += 1;
                if p?[j] != p?[k] {
                    next[j] = k;
                } else { //因为不能出现p[j] = p[next[j ]]，所以当出现时需要继续递归，k = next[k] = next[next[k]]
                    next[j] = next[k];
                }
            } else {
                k = next[k];
            }
        }
        return next;
    }
}

let so = Solution();
let result = so.kmpSearch("abaabababaaababaabaa","aabaa");

print(result);

```
原文地址 : [从头到尾彻底理解KMP]([https://www.cnblogs.com/zhangtianq/p/5839909.html)
通读了两遍 , 大概理解了 , 脑袋记不住只能存下来了