{-# LANGUAGE ScopedTypeVariables #-}

import Data.Foldable (Foldable, toList)

-- ========================================

-- data BinTree a = EmptyNode
--                   | FullNode (BinTree a) a (BinTree a)
--                   deriving Eq
--
-- instance Functor BinTree where
--     fmap _ EmptyNode = EmptyNode
--     fmap f (FullNode lx x rx) = FullNode (fmap f lx) (f x) (fmap f rx)
--
-- instance Applicative BinTree where
--     pure x          = FullNode EmptyNode x EmptyNode
--     EmptyNode <*> _ = EmptyNode
--     _ <*> EmptyNode = EmptyNode
--     (FullNode lf f rf) <*> (FullNode lx x rx) =
--          --             ... (fmap ($ f) t) (rf <*> t)
--          FullNode (lf <*> lx) (f x) (rf <*> rx)
--
-- instance Monad BinTree where
--     return = pure
--     EmptyNode >>= _ = EmptyNode
--     -- BinTree lx x rx >>= f = BinTree (lx >>= f) (f x) (rx >>= f)
--     FullNode lx x rx >>= f = f x
--
-- instance forall a. Show a => Show (BinTree a) where
--     show EmptyNode = "<>"
--     show (FullNode lx x rx) =  "[|" ++ show(lx)
--                                 ++ "|" ++  show(x)
--                                 ++ "|" ++ show(rx)
--                                 ++ "|]"
--
-- test_bintree :: IO ()
-- test_bintree = do
--     putStrLn "Entering test_bintree"
--     let lt = FullNode (FullNode EmptyNode 1 EmptyNode)
--                       EmptyNode
--                       (FullNode EmptyNode 2 EmptyNode)
--     let rt = FullNode (FullNode EmptyNode 3 EmptyNode)
--                       EmptyNode
--                       (FullNode EmptyNode 4 EmptyNode)
--     let t = FullNode lt EmptyNode rt
--     print t

-- ========================================

data LeafyBinTree a = Leaf a
                    | Branch (LeafyBinTree a) (LeafyBinTree a)
                    deriving Eq

instance Functor LeafyBinTree where
    fmap f (Leaf x) = Leaf (f x)
    fmap f (Branch lx rx) = Branch (fmap f lx) (fmap f rx)

instance Applicative LeafyBinTree where
    pure = Leaf
    Leaf f <*> Leaf x = Leaf (f x)
    Leaf f <*> Branch lx rx = Branch (fmap f lx) (fmap f rx)
    Branch lf rf <*> leaf@(Leaf x) = Branch (lf <*> leaf) (rf <*> leaf)
    Branch lf rf <*> Branch lx rx = Branch (lf <*> lx) (rf <*> rx)

instance Monad LeafyBinTree where
    return = pure
    Leaf a >>= f = f a
    Branch lx rx >>= f = Branch (lx >>= f) (rx >>= f)

instance (Show a) => Show (LeafyBinTree a) where
    show (Leaf x) = "<" ++ show(x) ++ ">"
    show (Branch lx rx) = "(" ++ show(lx) ++ ", " ++ show(rx) ++ ")"

test_leafybintree :: IO ()
test_leafybintree = do
    putStr "Entering test_leafybintree: "
    let t = Branch (Branch (Leaf 1) (Leaf 2)) (Branch (Leaf 3) (Leaf 4))
    print t

-- ========================================

for = flip map

data RoseTree a = RoseTree a [RoseTree a]
    deriving (Eq, Read)

instance Functor RoseTree where
    fmap f (RoseTree x ts) = RoseTree (f x) (fmap (fmap f) ts)

-- TODO: Compare with Data.Tree
instance Applicative RoseTree where
    pure x = RoseTree x []
    RoseTree f [] <*> xtree = f <$> xtree
    (RoseTree f fs) <*> xtree@(RoseTree x xs) =
        -- RoseTree (f x) (map (f <$>) xs ++ for fs (<*> xtree)) -- From Data.Tree
        RoseTree (f x) [fi <*> xi | fi <- fs, xi <- xs]

    -- TODO: Compare (<*) with liftA2 const
    RoseTree x xs <* ytree@(RoseTree _ ys) =
        RoseTree x (map (x <$) ys ++ for xs (<* ytree))

    -- TODO: Compare (*>) with liftA2 (flip const)
    RoseTree _ xs *> ytree@(RoseTree y ys) =
        RoseTree y (ys ++ for xs (*> ytree))

instance Monad RoseTree where
    return = pure
    RoseTree x xs >>= f = case f x of
        RoseTree x' xs' -> RoseTree x' (xs' ++ for xs (>>= f))

instance (Show a) => Show (RoseTree a) where
    show (RoseTree x []) = show(x) ++ "-[]"
    show (RoseTree x (rose : roses)) = show(x)
                                       ++ "-["
                                       ++ show(rose) ++ ":" ++ show(roses)
                                       ++ "]"

instance Foldable RoseTree where
    foldr f z (RoseTree x xs) = foldr f z (x : concat (fmap toList xs))
    foldMap f (RoseTree x xs) = f x `mappend` foldMap (foldMap f) xs

test_rosetree :: IO ()
test_rosetree = do
    putStr "Entering test_rosetree: "
    let t = RoseTree 1 [RoseTree 2 [RoseTree 3 [], RoseTree 4 [], RoseTree 5 []]]
    print t

-- ========================================

main = do
    -- test_bintree
    test_leafybintree
    test_rosetree
