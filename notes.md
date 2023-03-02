
## odd even machine
Is the number of 1's in the machine even? 

		 0               1
    +--------+      +--------+
    |   e    |----->|   o    |
    | even(0)|      | odd(1) |
    +--------+      +--------+

The above diagram has two states, even(0) and odd(1). The initial state is even(0) and the final state is also even(0) since an even number of 1s means the number of 1s is a multiple of 2, which is even.

δ(even(0), 0) = even(0)
δ(even(0), 1) = odd(1)
δ(odd(1), 0) = odd(1)
δ(odd(1), 1) = even(0)

## base 10 multiple of 3 

transition states are much more complex, I just used the machines we drew! 

States were: F, G, H, and I (because substring used abcde)

F -> 1 -> G -> 0 <- H <-> 1
F -> 0 -> I
G -> 1 -> I
I <-> 0, 1

etc. We can represent these specific changes using Haskell, which isn't that hard. 

# fst 

Here, Bit represents a binary digit (Zero or One), Binary represents a binary number (as a list of binary digits), and Decimal represents a decimal number. The BST type represents the state of the finite state transducer.

The binaryToDecimal FST translates from binary to decimal, and the decimalToBinary FST translates from decimal to binary. Both FSTs have three states:

Q0 represents the initial state.

This doesn't really work... I think there's something wrong with the way I'm outputting? 