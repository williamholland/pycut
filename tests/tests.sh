basic_comparison() {
  cmd=$1
  expected="$(eval "/usr/bin/cut $cmd")"
  actual="$(eval "../cut $cmd")"
  if [[ "$actual" != "$expected" ]]; then
    echo "\"$cmd\": failed."
    echo -e "actual:\n$actual"
    echo -e "expected:\n$expected"
  fi
}

# basic tests
basic_comparison "-d' ' -f 1 test.txt"
basic_comparison "-c 1 test.txt"
basic_comparison "-b 1 test.txt"

# ranges tests
basic_comparison "-b -5 test.txt"
basic_comparison "-b 5- test.txt"
basic_comparison "-b 1-7 test.txt"
basic_comparison "--complement -b 1-7 test.txt"

# -f no delimiter tests
basic_comparison "-d' ' -f 2 test2.txt"
basic_comparison "-s -d' ' -f 2 test2.txt"
basic_comparison "--complement -s -d' ' -f 2 test2.txt"

# output delimiter tests
basic_comparison "-b 1-7 --output-delimiter='|' test.txt"
basic_comparison "-c 1-7 --output-delimiter='|' test.txt"
basic_comparison "--output-delimiter='|' -d' ' -f 2-3 test2.txt"
