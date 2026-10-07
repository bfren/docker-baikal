use bf
bf env load

# Set environment variables
def main [] {
    bf env set BK_CONFIG "/config"
    bf env set BK_SRC_CONFIG $"(bf env BK_SRC)/config"

    # /data is the documented, declared volume (and the one ch.d/30-baikal owns
    # as www). Earlier versions linked Specific to /specific instead, so keep
    # using /specific when it already holds a database - existing installs that
    # mounted it as a workaround must not appear to lose their data.
    let legacy = "/specific/db"
    let data = if ($legacy | path exists) and (ls $legacy | is-not-empty) {
        bf write warn $"Using legacy data directory /specific - move its contents to /data and mount /data instead."
        "/specific"
    } else {
        "/data"
    }
    bf env set BK_DATA $data
    bf env set BK_SRC_SPECIFIC $"(bf env BK_SRC)/Specific"
}
