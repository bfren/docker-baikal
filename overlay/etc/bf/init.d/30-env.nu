use bf
bf env load

# Set environment variables
def main [] {
    bf env set BK_CONFIG "/config"
    bf env set BK_SRC_CONFIG $"(bf env BK_SRC)/config"

    bf env set BK_DATA "/specific"
    bf env set BK_SRC_SPECIFIC $"(bf env BK_SRC)/Specific"
}
