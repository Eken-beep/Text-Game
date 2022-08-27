{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_game (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/edvin/.cabal/bin"
libdir     = "/home/edvin/.cabal/lib/x86_64-linux-ghc-9.0.2/game-0.1.0.0-inplace-game"
dynlibdir  = "/home/edvin/.cabal/lib/x86_64-linux-ghc-9.0.2"
datadir    = "/home/edvin/.cabal/share/x86_64-linux-ghc-9.0.2/game-0.1.0.0"
libexecdir = "/home/edvin/.cabal/libexec/x86_64-linux-ghc-9.0.2/game-0.1.0.0"
sysconfdir = "/home/edvin/.cabal/etc"

getBinDir     = catchIO (getEnv "game_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "game_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "game_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "game_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "game_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "game_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
