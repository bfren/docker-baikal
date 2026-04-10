use bf
bf env load

def main [] {
    bf write "Linking source to volume..."
    create_if_not_link (bf env BK_SRC_CONFIG) (bf env BK_CONFIG)
    create_if_not_link (bf env BK_SRC_SPECIFIC) (bf env BK_SPECIFIC)

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

        rm --force $link
        ^ln -s $target $link
    }
}
