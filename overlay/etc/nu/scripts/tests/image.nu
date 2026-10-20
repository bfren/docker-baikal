use std/assert
use bf

const src = "/etc/bf/src/baikal"


#======================================================================================================================
# installation
#======================================================================================================================

export def install__source_is_read_only_and_owned_by_www [] {
    assert equal "www:www 500" (^stat -c "%U:%G %a" $src | str trim) "the source directory should be read-only"
    assert equal "www:www 400" (^stat -c "%U:%G %a" $"($src)/html/index.php" | str trim) "source files should be read-only"
}

export def install__baikal_version_matches_build [] {
    let expected = with-env {BF_ETC: "/etc/bf"} { bf build | get Baikal }
    let found = glob $"($src)/Core/**/*.php" | any {|x| open --raw $x | str contains $expected }

    assert $found $"Baikal's Core files should contain version ($expected)"
}

export def install__database_and_required_extensions_are_loaded [] {
    let modules = ^php -m | lines | str trim | str lowercase
    let required = [curl dom pdo_mysql pdo_pgsql pdo_sqlite simplexml xmlreader xmlwriter]

    for x in $required { assert ($x in $modules) $"the ($x) extension should be loaded" }
}


#======================================================================================================================
# nginx
#======================================================================================================================

export def nginx__well_known_redirects_are_configured [] {
    let conf = open --raw /etc/nginx/helpers/php-try-php.conf

    assert ($conf =~ 'rewrite \^/\.well-known/caldav /dav\.php') "/.well-known/caldav should redirect to dav.php"
    assert ($conf =~ 'rewrite \^/\.well-known/carddav /dav\.php') "/.well-known/carddav should redirect to dav.php"
}

export def nginx__baikal_configuration_is_valid [] {
    # test a copy, as tests run in parallel
    let dir = mktemp --directory
    ^cp -a /etc/nginx/. $dir
    let result = ^nginx -t -c $"($dir)/nginx.conf" | complete
    rm --recursive --force $dir

    assert equal 0 $result.exit_code $"nginx -t failed: ($result.stderr)"
}
