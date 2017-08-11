-- | Where we define C-side types to handle in inline-c
{-# LANGUAGE OverloadedLists #-}
module Game.TCOD.Context(
    tcodContext
  -- * Types
  , Color(..)
  , TCODHeightMap(..)
  , Dice(..)
  -- * Reexports
  , C.context
  , C.include
  , C.verbatim
  , C.exp
  , C.block
  , C.funCtx
  ) where

import qualified Language.C.Inline as C
import qualified Language.C.Inline.Context as C
import qualified Language.C.Types as C

import Data.Monoid
import Data.Word
import Foreign.C
import GHC.Generics

import Data.Array.Repa (Array, DIM2)
import Data.Array.Repa.Repr.ForeignPtr (F)

-- | 24 bit color
data Color = Color {
  colorR :: {-# UNPACK #-} !Word8
, colorG :: {-# UNPACK #-} !Word8
, colorB :: {-# UNPACK #-} !Word8
} deriving (Eq, Ord, Show, Generic)

-- | TCOD heighmap object is represented via 2-dimensional array
newtype TCODHeightMap = TCODHeightMap { unTCODHeightMap :: Array F DIM2 CFloat }

-- | Dice roll
data Dice = Dice {
  diceNbRolls     :: {-# UNPACK #-} !Int
, diceNbFaces     :: {-# UNPACK #-} !Int
, diceMultiplier  :: {-# UNPACK #-} !Double
, diceAddSub      :: {-# UNPACK #-} !Double
} deriving (Eq, Show, Generic)

tcodContext :: C.Context
tcodContext = C.baseCtx <> mempty {
    C.ctxTypesTable = [
      (C.TypeName "TCOD_color_t", [t| Color |])
    , (C.TypeName "TCOD_heightmap_t", [t| TCODHeightMap |])
    , (C.TypeName "TCOD_dice_t", [t| Dice |])
    ]
  }
