module Main where

import System.Environment (getArgs)
import System.IO          (readFile, writeFile)
import System.FilePath    (replaceExtension, takeExtension)

data Format = Normal
            | Literate
            deriving (Eq, Read)

data Mode   = Comment
            | Code

comment = "-- Comment"
code    = "-- Code"

prefixLine :: Format -> Mode -> String
prefixLine Normal   Comment = "-- "
prefixLine Literate Code    = "> "
prefixLine _        _       = ""

newExtension :: Format -> FilePath -> String
newExtension f fp =
  let prefix = if f == Literate then "l" else ""
  in  prefix ++ (drop 2 $ takeExtension fp)

processFile :: Format -> Mode -> [String] -> [String]
processFile f m ls = go m [""] ls
  where
    go _ acc []                    = acc
    go m acc (l:xs) | l == comment = go Comment acc xs
                    | l == code    = go Code    acc xs
                    | l == ""      = go m       (acc ++ [""]) xs
                    | otherwise    = go m       (acc ++ [prefixLine f m ++ l]) xs

main :: IO ()
main = do
  args <- getArgs

  let format  = read $ args !! 0
      file    = args !! 1
      newFile = replaceExtension file (newExtension format file)

  contents <- readFile file

  let (mode : rest) = lines contents
      startMode = if mode == code then Code else Comment
      output    = unlines . tail $ processFile format startMode rest

  writeFile newFile output
