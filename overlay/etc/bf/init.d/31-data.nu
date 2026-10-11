use bf
bf env load

# Ensure db directory exists in /data with correct permissions
def main [] {
    let db = $"(bf env BAIKAL_DATA_D)db"
    if ($db | bf fs is_not_dir ) {
        mkdir $db
        bf ch apply_file "30-baikal"
    }
}
