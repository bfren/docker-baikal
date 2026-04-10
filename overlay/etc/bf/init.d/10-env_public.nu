use bf
bf env load

# Override Nginx public environment variable to point to Baikal source
def main [] {
    let bk_src = $"(bf env ETC_SRC)/baikal"
    bf env set BK_SRC $bk_src
    bf env set NGINX_PUBLIC $"($bk_src)/html"
}
