#! /bin/bash

set -euox pipefail

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
            language=$(basename $1)
            echo "[${language}] Benchmarking..."
            make run &
            sleep 5
            ${WRK} -t12 -c400 -d10s http://127.0.0.1:8080
            echo "[${language}] Benchmarking done!"
            set +u
            if [[ -z ${GITHUB_RUN_ID} ]]; then
                # NOTE: do not do this in action, as it will kill the action itself
                pkill -f ${language} > /dev/null
            fi
            set -u
            popd
            shift
    esac
done
