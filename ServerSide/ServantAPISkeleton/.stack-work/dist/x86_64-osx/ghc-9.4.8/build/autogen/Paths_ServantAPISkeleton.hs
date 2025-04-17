{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_ServantAPISkeleton (
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
bindir     = "/Users/keaton/Dev/OutdoorAdManager/ServerSide/ServantAPISkeleton/.stack-work/install/x86_64-osx/decc7d9bdf0df0a3e23d0e9894c77a98c2896789eac5bfa314519623a78b34b9/9.4.8/bin"
libdir     = "/Users/keaton/Dev/OutdoorAdManager/ServerSide/ServantAPISkeleton/.stack-work/install/x86_64-osx/decc7d9bdf0df0a3e23d0e9894c77a98c2896789eac5bfa314519623a78b34b9/9.4.8/lib/x86_64-osx-ghc-9.4.8/ServantAPISkeleton-0.1.0.0-IObHXtQU8BQ2Va5qDu2XKa"
dynlibdir  = "/Users/keaton/Dev/OutdoorAdManager/ServerSide/ServantAPISkeleton/.stack-work/install/x86_64-osx/decc7d9bdf0df0a3e23d0e9894c77a98c2896789eac5bfa314519623a78b34b9/9.4.8/lib/x86_64-osx-ghc-9.4.8"
datadir    = "/Users/keaton/Dev/OutdoorAdManager/ServerSide/ServantAPISkeleton/.stack-work/install/x86_64-osx/decc7d9bdf0df0a3e23d0e9894c77a98c2896789eac5bfa314519623a78b34b9/9.4.8/share/x86_64-osx-ghc-9.4.8/ServantAPISkeleton-0.1.0.0"
libexecdir = "/Users/keaton/Dev/OutdoorAdManager/ServerSide/ServantAPISkeleton/.stack-work/install/x86_64-osx/decc7d9bdf0df0a3e23d0e9894c77a98c2896789eac5bfa314519623a78b34b9/9.4.8/libexec/x86_64-osx-ghc-9.4.8/ServantAPISkeleton-0.1.0.0"
sysconfdir = "/Users/keaton/Dev/OutdoorAdManager/ServerSide/ServantAPISkeleton/.stack-work/install/x86_64-osx/decc7d9bdf0df0a3e23d0e9894c77a98c2896789eac5bfa314519623a78b34b9/9.4.8/etc"

getBinDir     = catchIO (getEnv "ServantAPISkeleton_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "ServantAPISkeleton_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "ServantAPISkeleton_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "ServantAPISkeleton_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ServantAPISkeleton_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ServantAPISkeleton_sysconfdir") (\_ -> return sysconfdir)




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
