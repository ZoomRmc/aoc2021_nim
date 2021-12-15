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

### Day 15
<details>
<summary>Day 15 spoiler</summary>
This is the first day I had to consult an algo book, after realising that the problem statement is classical Dijkstra's algorithm. Initial implementation is a textbook version which doesn't have much of a sense of direction. Needless to say, blindly calculating everything and using wrong data structures leads to abysmal performance. Initially it needed minutes to finish calculating Part 2, but after migrating to the UCS variation of the algo, the running time dropped to a few seconds. Using `std/heapqueue` gets us to a sub-second performance. Good enough.

Interestingly, HeapQueue worked almost as well even when no custom comparison (`<`) function was provided. Instead of choosing the coordinates with the minimal weight from a distance table, it used the coordinates themselves so always provided the point closer to the starting coordinates. 
</details>

### Day 7
<details>
<summary>Day 7 spoiler</summary>
Part 1 is just a median. However, it requires a sorted array, and why have that when summing a bunch of differences is almost as cheap for the provided input. Plus, we can solve both parts iterating the input only once, as the second part requires to calculate the triangle numbers. Easy with the famous Gauss trick. If the input were to be much larger, the math (sort, median and mean) is the way to go for both parts (for 100000 numbers of `0..<100000` it will be ~ 500 times faster).
</details>