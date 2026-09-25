use bf
bf env load

def main [] {
    bf write "Linking source to volume..."
    create_if_not_link (bf env BK_SRC_CONFIG) (bf env BK_CONFIG)
    create_if_not_link (bf env BK_SRC_SPECIFIC) (bf env BK_DATA)

    # Baikal refuses to install unless the SQLite file's folder already exists
    # and is writable; replacing Specific with the link drops the bundled db/,
    # and ch.d has already run by now, so create and own it here.
    let db = $"(bf env BK_DATA)/db"
    if not ($db | path exists) {
        bf write debug $" .. creating ($db)"
        mkdir $db
        ^chown www:www $db
    }

    return
}

# Create a link to a target if the link does not exist.
def create_if_not_link [
    link: string    # Path to the link to check
    target: string  # Target to use if $link does not exist
] {
    if ($link | bf fs is_not_symlink) {
        bf write debug $" .. ($link) to ($target)"
        if not ($target | path exists) {
            mkdir $target
        }

        rm --force --recursive $link
        ^ln -s $target $link
    }
}
