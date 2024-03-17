#! /bin/bash

set -euo pipefail

cd $(dirname ${BASH_SOURCE[0]})

PLATFORM=$(uname -s)
case ${PLATFORM} in
    Linux)
        WRK=$(realpath ${WRK:-../bin/linux_amd64/wrk})
        ;;
    Darwin)
        WRK=$(realpath ${WRK:-../bin/osx_arm/wrk})
        ;;
    *)
        echo "Unsupported platform: ${PLATFORM}"
        exit 1
        ;;
esac

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
            langframe=$(basename $1)
            echo "[${langframe}] Benchmarking..."
            make
            make run
            # Wait for server to start
            while ! lsof -i :8080 > /dev/null; do sleep 1; done
            REPORT=../${langframe}.report
            rm -f ${REPORT}
            ${WRK} -t12 -c400 -d10s http://127.0.0.1:8080 | tee ${REPORT}
            echo "[${langframe}] Benchmarking done!"
            set +u
            if [[ -z ${GITHUB_RUN_ID} ]]; then
                # NOTE: do not do this in action, as it will kill the action itself
                lsof -i :8080 | awk '{print $2}' | tail -n 1 | xargs kill -9
            fi
            set -u
            popd
            shift
    esac
done
