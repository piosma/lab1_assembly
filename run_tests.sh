#!/bin/bash

# Przechodzimy przez wszystkie pliki .in w folderze tests/
for test in tests/*.in; do
    test_name=$(basename "$test" .in)   # Pobieramy nazwę testu bez rozszerzenia
    ./program1 < "$test" > "tests/$test_name.result"   # Uruchamiamy program i zapisujemy wynik

    # Porównujemy wynik z oczekiwanym wyjściem
    if diff -q "tests/$test_name.out" "tests/$test_name.result" >/dev/null; then
        echo "[OK] $test_name"
    else
        echo "[FAIL] $test_name"
        diff "tests/$test_name.out" "tests/$test_name.result"
    fi
done
