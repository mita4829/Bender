# Bender

[![Build Status](https://travis-ci.org/mita4829/Bender.svg?branch=master)](https://travis-ci.org/mita4829/Bender)
<p>Simple iOS calculator written in Swift. This project demostrate recursive-descent parsing to achieve order of operations.</p>   
<p>There is a small issue of handling integers greater than 64-bits which cause overflows. Currently, expressions and values that are evaulated are casted to be 32-bits and if integers are detected to be greater, an overflow alert view will be delegated out. Swift 3 does not handle overflows well concerning 64-bit integers. Future work of dynammically resizing space allowing integers to exceed 64-bits will be needed. Theme from CalcBot @tapbots</p>

![Alt text](https://github.com/mita4829/Bender/blob/master/SS.png "Bender")
