iBooks Comments
===============

This is a tiny that to access user's comments in books from iBooks.

For now it just generates a mrkdown file with all comments for all books.

Usage
-----

iBooks stores books and comments data in 2 folders: `~/Library/Containers/com.apple.iBooksX/Data/Documents/BKLibrary` and `~/Library/Containers/com.apple.iBooksX/Data/Documents/AEAnnotation`.
That is valid in time of writing, that actually might change later.
Both paths must be provided to script via ENV variables:
`LIBRARY_DIR=BKLibrary ANNOTATION_DIR=AEAnnotation ruby ibooks.rb`
