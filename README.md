# Normlit

I'm sick of having to decide if I want a literate version of a program or if I
want the normal version. Changing the format after writing the program is a pain
in the arse.

Now, I don't have to decide.


## Example

Normlit expects a file with a `n` prefixed on to the normal file extension
(Normlit Haskell, maybe).  For example, instead of creating `foo.hs` or
`foo.lhs`create `foo.nhs`.

In Normlit, a block of text that represents code should have `-- Code` on a
separate line before the code. A block of text that represents a comment should
have `-- Comment`. For example, here's the contents of `simple.nhs`:

    -- Code
    module Simple where

    data Bool = True
              | False
              deriving (Eq, Read, Show)

    -- Comment
    This is a comment

To convert this into the literate form, run: `./normlit Literate simple.nhs`

This will create `simple.lhs` with content:

    > module Simple where

    > data Bool = True
    >           | False
    >           deriving (Eq, Read, Show)

    This is a comment

If you prefer the normal file format, run: `./normlit Normal simple.nhs`. This
creates `simple.hs` with content:

    module Simple where

    data Bool = True
              | False
              deriving (Eq, Read, Show)

    -- This is a comment


## Building the project

`ghc --make -O2 Normlit.hs -o normlit`


## Running

    ./normlit Normal foo.nhs

    ./normlit Literate foo.nhs


## Required work

* Use proper command line arguments. `-l` for literate mode, default to normal mode
* Alternative to `-- <mode>` to signify a block type. Since `--` starts a Haskell (& friends) style comment, it would be nice if this was configurable so that other languages with literate forms can be output.
