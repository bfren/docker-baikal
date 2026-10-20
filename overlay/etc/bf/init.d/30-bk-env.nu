use bf
use bf-nginx-php
bf env load

# Add Baikal environment variables to FPM
def main [] {
    let variables = [
        [key, override];
        [BF_BAIKAL_CONFIG_D, BAIKAL_PATH_CONFIG]
        [BF_BAIKAL_DATA_D, BAIKAL_PATH_SPECIFIC]
    ]

    bf-nginx-php load-env $variables
}
