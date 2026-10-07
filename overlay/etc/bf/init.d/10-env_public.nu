use bf
bf env load

# Override Nginx public environment variable to point to Baikal source
def main [] {
    bf env set NGINX_PUBLIC $"(bf env ETC_SRC)/baikal/html"
}
