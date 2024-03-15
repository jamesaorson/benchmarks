#! /bin/bash

set -euo pipefail

show_help() {
    echo "Usage: ./benchmark.bash <path_to_benchmark>"
    echo "Benchmark the given HTTP implementation"
}

if [[ $# -eq 0 ]]; then
    show_help
    exit 1
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h)
            show_help
            exit 0
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            pushd $1
            language=$(basename $1)
            echo "[${language}] Benchmarking"
            make run
            sleep 5
            wrk -t12 -c400 -d10s http://127.0.0.1:8080
            pkill -f ${language} > /dev/null
            popd
            shift
    esac
done
