class Monoid m where
      mempty  :: m
      mappend :: m -> m -> m
      mconcat :: [m] -> m
      mconcat = foldr mappend mempty -- point-free, of course
(<>) :: Monoid m => m -> m -> m
(<>) = mappend

-- monoid laws:
-- mempty is the identity element of m
-- mappend is associative
--     lets us write a <> b <> c <> d

newtype Sum a = Sum a
	deriving (Eq, Num, Ord, Show)
		    -- ^ bug report sent to byorgey. Num doesn't seem to be derivable
		    -- Got a reply:
		    I think what I intended is to enable the extension
  		    {-# LANGUAGE GeneralizedNewtypeDeriving #-}
  		    at the top of the .hs file.  Then Num can indeed be derived for
		    newtypes like Sum.
	
-- instance Num a => Num (Sum a) where
-- (+) (Sum b) (Sum c) = Sum (b+c)

-- -- Deriving with Num defines operators like +, * to be
-- -- Sum a + Sum b = Sum (a+b)
-- -- Sum a * Sum b = Sum (a*b) etc. Given that a and b are Num
-- -- And hence the type class instantiation goes like:

instance Num a => Monoid (Sum a) where
	 mempty = Sum 0
	 mappend = (+) -- notice this need not be written mappend (Sum a) (Sum b) = Sum (a+b)
	 	       -- if Num were derivable