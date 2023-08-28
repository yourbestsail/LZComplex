## The struct LZComplex, together with the global funtions defined in the package and the LZComplex extension where the most important operators are overloaded, handles the math of complex numbers.

var c = LZComplex(re: 2, im: 4)
print(c) // gives 2 + 4i

List of operations:
c** // gives the square of c
log(c) // natural log of c
c^3 // power 3 of c
c1^c2 // powr c2 of c1
c1 + c2
c1 - c2
c1 * c2
c1 / c2
-c1
abs(c) // modulus of c
sqrt(c) // root square of c
c* // coniugate of c
c1 += c2 // c1 = c1 + c2
c1 -= c2 // c1 = c1 - c2
c1 *= c2 // c1 = c1 * c2
c1 /= c2 // c1 = c1 / c2

