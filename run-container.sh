RUN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
podman run -it -v ${RUN_DIR}:/data:z fedora:uub_personverser