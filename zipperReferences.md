# Derivatives of Regular Types — Resources

## Introductions to zippers

1. [You Could Have Invented Zippers, by Edward Z. Yang](http://blog.ezyang.com/2010/04/you-could-have-invented-zippers/).
..* A good introduction to zippers.
2. [The chapter on Zippers from LYAH, by Miran Lipovača](http://learnyouahaskell.com/zippers).
..* Another good introduction to zippers — a better introduction than Huet's paper.
3. [FUNCTIONAL PEARLS: The Zipper, by Gérard Huet](http://gallium.inria.fr/~huet/PUBLIC/zip.pdf).
..* The paper that announced to the world the idea of (tree) zippers, which had been long-known in some circles, but never before published.
4. [Zippers, Derivatives -- Oh what fun!, by Travis Athougies](http://travis.athougies.net/posts/2015-01-16-zippers-derivatives-oh-what-fun.html).
..* data Rose a = Rose a [Rose a]
..* data DRose a = DRose [Rose a] [(a, [Rose a], [Rose a])]
..* Children = [Rose a]
..* Breadcrumbs = [(a, [Rose a], [Rose a])]
5. Zipper wikis ([Wikibooks](https://en.wikibooks.org/wiki/Haskell/Zippers),  [haskell.org](https://wiki.haskell.org/Zipper))
6. [Zippers and Data Type Derivatives, by Simon Roßkopf](https://www21.in.tum.de/teaching/fp/SS15/papers/11.pdf) 
7. Zippers, by Pavel Panchekha ([Part 1](https://pavpanchekha.com/blog/zippers/huet.html), [Part 2](https://pavpanchekha.com/blog/zippers/derivative.html) [Part 3] (https://pavpanchekha.com/blog/zippers/kiselyov.html), [Part 4](https://pavpanchekha.com/blog/zippers/multi-zippers.html))
8. The Algebra of Algebraic Data Types, by Chris Taylor ([Part 3](http://chris-taylor.github.io/blog/2013/02/13/the-algebra-of-algebraic-data-types-part-iii/))

## Some papers by Conor McBride

9. [The Derivative of a Regular Type is its Type of One-Hole Contexts, by Conor McBride](strictlypositive.org/diff.pdf).
..* The paper that followed Huet's, and greatly helped spread the word about zippers.  Here "regular" basically means built upon primitive types, and closed under sum, product, and (least) fixed points.
10. [∂ for Data: Differentiating Data Structures, by Conor McBride, et. al.](http://strictlypositive.org/dfordata.pdf)
..* Formal approach, using sequent calculus.
11. [Clowns to the left of me, jokers to the right (Dissecting Data Structures), by Conor McBride](http://strictlypositive.org/Dissect.pdf) 
..* Formal approach.

## Implementing Zippers

12. [Several papers on implementing zippers as delimited continuations, by Oleg Kiselyov](http://okmij.org/ftp/continuations/zipper.html)
..* Kiselyov's implementation is fundamentally different from that of Huet/McBride.  Kiselyov treats derivatives not as data types, but as traversal functions using CPS (Continuation Passing Style).
13. [Hackage's implementation of zippers based on Kiselyov's traversal work](https://hackage.haskell.org/package/zippers) 
14. ["Generic Haskell: practice and theory", by Ralph Hinze and Johan Jeuring](http://www.cs.uu.nl/research/techreps/repo/CS-2003/2003-015.pdf)
..* Create derivative types at runtime using a custom Haskell build.  Also, see [Exploring Generic Haskell, a thesis by Andres Löh](https://www.andres-loeh.de/ExploringGH.pdf)

## Applications of Zippers

15. [xmonad](http://xmonad.org/): "The tiling window manager that rocks" 
16. [Zipper-based file server/OS](http://okmij.org/ftp/continuations/zipper.html#zipper-fs) [ZFS]
..* "A referentially transparent filesystem with transactional semantics in 540 lines of Haskell."
..* "We thus demonstrate how delimited continuations let us statically isolate effects even if the whole program eventually runs in an IO monad."
17. [Strengthening the Zipper, by Tristan Allwood and Susan Eisenbach](https://www.doc.ic.ac.uk/~tora/clase/CLASE-Medium.pdf)
..* A zipper-based tool to traverse heterogeneous data types: specifically, Haskell expressions. 

## Zippers & Taylor Series

18. ["A Taylor Series for Types", by Dan Piponi](http://blog.sigfpe.com/2006/06/taylor-series-for-types.html)
..* The denominator in Taylor's series can be interpreted as the number of permutations of a set.
..* Note that X^2 is not isomorphic to 2*X^2/2, since info on ordering is lost.
  * F[X + Y] = exp(Y d/dX)  F[X]
19. [Seven Trees in One, by Andreas Blass](https://arxiv.org/abs/math/9405205)
..* Takes a bit of intuition gained from a Taylor series (that there is a bijection between the set of all seven-tuples of binary trees and the set of all trees) and formalizes it.

## Higher Order Zippers

20. [Higher Order Zippers, by Christophe Poucet](http://blog.poucet.org/2007/07/higher-order-zippers/)
..* This provides the intuition that second-order zippers provide O(1) splicing, but I think this is based too much on the case of Lists, and is an oversimplification in the generic case.  
21. ["Two-hole zippers and transactions of various isolation modes", by Oleg Kiselyov](https://mail.haskell.org/pipermail/haskell/2005-May/015844.html)
..* This shows how zippers with multiple holes can represent transactions run in parallel, including all the ISO standard isolation levels, and more.
22. ["A blessed man's formula for holey containers", by Dan Piponi](http://blog.sigfpe.com/2008/06/blessed-mans-formula-for-holey.html)
..* The "blessed man" here is (Francesco) Faà di Bruno, a 19th century Italian priest and mathematician, who discovered a formula for the nth derivative of a composition of function.

## Zippers vs. lenses

23.  [Stackoverflow: Differences between lenses and zippers](http://stackoverflow.com/questions/22094971/what-are-the-differences-between-lenses-and-zippers)
..* "Zippers are akin to cursors: they allow to traverse trees in an ordered manner. Their usual operations are up, down, left, right and edit. (names may vary depending on impl)"
..* "Lenses are some sort of generalized keys (as in "keys of an associative datastructure"). The structure does not need to be ordered. Their usual operations are fetch and putback and are very similar to get and assoc. (names may vary depending on impl)"
24. [From Zipper to Lens](https://www.schoolofhaskell.com/user/psygnisfive/from-zipper-to-lens)

## Zippers and monads

25. [The Monads Behind Every Zipper, by Dan Piponi](http://blog.sigfpe.com/2007/01/monads-hidden-behind-every-zipper.html) 
26. ["Structured Computation on Trees or, What's Behind That Zipper? (A Comonad)"](http://cs.ioc.ee/~tarmo/tsem05/uustalu0812-slides.pdf)
..* "The zipper datatype hides a comonad.  This is exactly the comonad one needs to structure attribute evaluation". 
27. [Functional Pearl: The Monad Zipper, by Tom Schrijvers and Bruno C. d. S. Oliveira](http://ropas.snu.ac.kr/~bruno/papers/MonadZipper.pdf)
..* Use a zipper to help navigate a monad stack.
..* Uses the monad transformer library Monatron (Jaskelioff 2008), which is now on Hackage.

## Other topics

28. [The Two Dualities of Computation: Negative and Fractional Types, by Roshan James and Amr Sabry](https://www.cs.indiana.edu/~sabry/papers/rational.pdf). 
..* Negative types are ones that "flow backwards" to fill in arguments (using additive duality)
..* Fractional types are values that impose constraints on their context (using multiplicative duality)
