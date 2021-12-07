# aoc2021_nim
AoC 2021 in Nim

## Previous years:
 - [2020](https://github.com/ZoomRmc/aoc2020_nim)

## General notes
What I'm trying to stick to while writing the solutions, in order of importance:
 - Intelligible implementation logic, clear data flow
 - Brevity must not hurt readability
 - Short, self-sustaining functions with evident behaviour, hopefully as "strict" as reasonable
 - Keep the solutions for both parts of the task separated (one should work in case the other was removed from the code), extract repeating computations to functions/templates
 - Use the more suitable data structures available (it's tempting and boring to solve *everything* with Hash Tables)
 - Explore standard library before jumping to external libs

## Notes on specific days
**Spoilers below!**

### Day 7
<details>
<summary>Day 7 spoiler</summary>
Part 1 is just a median. However, it requires a sorted array, and why have that when summing a bunch of differences is almost as cheap for the provided input. Plus, we can solve both parts iterating the input only once, as the second part requires to calculate the triangle numbers. Easy with the famous Gauss trick. If the input were to be much larger, the math (sort, median and mean) is the way to go for both parts (for 100000 numbers of `0..<100000` it will be ~ 500 times faster).
</details>