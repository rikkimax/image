// Written in the D programming language.
/**
Math utility code.

For internal use only.

Authors:    Manu Evans
Copyright:  Copyright (c) 2019, Manu Evans.
License:    $(WEB boost.org/LICENSE_1_0.txt, Boost License 1.0)
*/
module wg.util.math;

///
pragma(inline, true)
F[3] multiply(F)(auto ref const F[3][3] m1, auto ref const F[3] v) @safe pure nothrow @nogc
{
    return [ m1[0][0]*v[0] + m1[0][1]*v[1] + m1[0][2]*v[2],
             m1[1][0]*v[0] + m1[1][1]*v[1] + m1[1][2]*v[2],
             m1[2][0]*v[0] + m1[2][1]*v[1] + m1[2][2]*v[2] ];
}

///
pragma(inline, true)
F[3][3] multiply(F)(auto ref const F[3][3] m1, auto ref const F[3][3] m2) @safe pure nothrow @nogc
{
    return [[ m1[0][0]*m2[0][0] + m1[0][1]*m2[1][0] + m1[0][2]*m2[2][0],
              m1[0][0]*m2[0][1] + m1[0][1]*m2[1][1] + m1[0][2]*m2[2][1],
              m1[0][0]*m2[0][2] + m1[0][1]*m2[1][2] + m1[0][2]*m2[2][2] ],
            [ m1[1][0]*m2[0][0] + m1[1][1]*m2[1][0] + m1[1][2]*m2[2][0],
              m1[1][0]*m2[0][1] + m1[1][1]*m2[1][1] + m1[1][2]*m2[2][1],
              m1[1][0]*m2[0][2] + m1[1][1]*m2[1][2] + m1[1][2]*m2[2][2] ],
            [ m1[2][0]*m2[0][0] + m1[2][1]*m2[1][0] + m1[2][2]*m2[2][0],
              m1[2][0]*m2[0][1] + m1[2][1]*m2[1][1] + m1[2][2]*m2[2][1],
              m1[2][0]*m2[0][2] + m1[2][1]*m2[1][2] + m1[2][2]*m2[2][2] ]];
}

///
pragma(inline, true)
F[3][3] transpose(F)(auto ref const F[3][3] m) @safe pure nothrow @nogc
{
    return [[ m[0][0], m[1][0], m[2][0] ],
            [ m[0][1], m[1][1], m[2][1] ],
            [ m[0][2], m[1][2], m[2][2] ]];
}

///
pragma(inline, true)
F determinant(F)(auto ref const F[3][3] m) @safe pure nothrow @nogc
{
    return m[0][0] * (m[1][1]*m[2][2] - m[2][1]*m[1][2]) -
           m[0][1] * (m[1][0]*m[2][2] - m[1][2]*m[2][0]) +
           m[0][2] * (m[1][0]*m[2][1] - m[1][1]*m[2][0]);
}

///
F[3][3] inverse(F)(auto ref const F[3][3] m) @safe pure nothrow @nogc
{
    F det = determinant(m);
    assert(det != 0, "Matrix is not invertible!");

    F invDet = F(1)/det;
    return [[ (m[1][1]*m[2][2] - m[2][1]*m[1][2]) * invDet,
              (m[0][2]*m[2][1] - m[0][1]*m[2][2]) * invDet,
              (m[0][1]*m[1][2] - m[0][2]*m[1][1]) * invDet ],
            [ (m[1][2]*m[2][0] - m[1][0]*m[2][2]) * invDet,
              (m[0][0]*m[2][2] - m[0][2]*m[2][0]) * invDet,
              (m[1][0]*m[0][2] - m[0][0]*m[1][2]) * invDet ],
            [ (m[1][0]*m[2][1] - m[2][0]*m[1][1]) * invDet,
              (m[2][0]*m[0][1] - m[0][0]*m[2][1]) * invDet,
              (m[0][0]*m[1][1] - m[1][0]*m[0][1]) * invDet ]];
}
