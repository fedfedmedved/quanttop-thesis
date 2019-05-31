file="${1:--}"
if [ "$file" = - ]; then
    file="$(mktemp)"
    cat >"${file}"
fi
awk '
FNR == 1 { if (NR == FNR) next }
NR == FNR {
    for (i = 1; i <= NF; i++) {
        l = length($i)
        if (w[i] < l)
            w[i] = l
    }
    next
}
{
    for (i = 1; i <= NF; i++)
        printf "%*s", w[i] + (i > 1 ? 1 : 0), $i
    print ""
}
' "$file" "$file"
if [ "$file" = - ]; then
    rm "$file"
fi

