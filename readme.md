iBooks Comments
===============

This is a tiny that to access user's comments in books from iBooks.

For now it just generates a mrkdown file with all comments for all books.

Usage
-----

iBooks stores books and comments data in `~/Library/Containers/com.apple.iBooksX/Data/Documents`.
That is valid in time of writing, that actually might change later.
Both paths must be provided to script via ENV variables:
`DATA_DIR=iBooksX/Data/Documents ruby ibooks.rb`
