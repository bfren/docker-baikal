use bf
bf env load

# Earlier versions linked Specific to /specific instead of /data - if there is
# data in there, warn and stop the container - otherwise, ensure /data/db exists
def main [] {
    # stop container if legacy setup detected
    let legacy = "/specific/db"
    let data = bf env BAIKAL_DATA_D
    let config = bf env BAIKAL_CONFIG_D
    if ($legacy | path exists ) and (ls $legacy | is-not-empty) {
        [
            "Legacy setup detected - "
            $"please move db directory from ($legacy) to ($data), "
            $"update 'sqlite_file' in ($config)/baikal.yaml"
            "and restart your container."
        ]
            | str join
            | bf write error $in
    }

    # path to correct db directory - trailing slash is required for BAIKAL_PATH_SPECIFIC so don't add it here
    let db = $"($data)db"
    if ($db | bf fs is_not_dir ) {
        mkdir $db
        bf ch apply_file "30-baikal"
    }
}
