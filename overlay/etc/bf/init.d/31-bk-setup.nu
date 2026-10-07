use bf
bf env load

def main [] {
    # check for legacy setup
    check_legacy

    # link volumes
    bf write "Linking source to volumes..."
    create_if_not_link (bf env BK_SRC_CONFIG) (bf env BK_CONFIG)
    create_if_not_link (bf env BK_SRC_SPECIFIC) (bf env BK_DATA)

    # ensure db directory exists so Baikal fresh installation works
    mkdir $"(bf env BK_DATA)/db"

    return
}

# Earlier versions linked Specific to /specific instead of /data - if there is
# data in there, warn and stop the container
def check_legacy [] {
    # path to legacy database directory
    let legacy = "/specific/db"

    # stop container if legacy setup detected
    if ($legacy | path exists ) {
        bf write error $"Legacy setup detected - please move ($legacy) to (bf env BK_DATA) and restart."
    }
}

# Create a link if it does not exist.
def create_if_not_link [
    link: string    # Path to the link to check
    source: string  # Source file to use if $link does not exist
] {
    if ($link | bf fs is_not_symlink) {
        bf write debug $" .. ($link) to ($source)"

        # create target
        if not ($source | path exists) {
            mkdir $source
        }

        # move any existing files to the target
        ls --all --full-paths $link | each {|file|
            bf write debug $"Moving ($file.name) to ($source)..." script?
            mv $file.name $source
        }

        # delete and remake as link
        rm --force --recursive $link
        ^ln -s $source $link
    }
}
