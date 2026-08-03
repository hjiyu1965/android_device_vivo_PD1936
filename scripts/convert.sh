#!/bin/bash
# convert.sh - 将 .dependencies 文件转换为 repo local manifest
# 来源: azwhikaru/Action-TWRP-Builder
# 用法: bash convert.sh <path-to-dependencies-file> [<path-to-local-manifest>]

if [ -n "$1" ] && [ -e "$1" ]; then
    file="$1"
else
    echo " ** 输入文件: $1 不存在"
    echo " ** 请指定正确的 dependencies 文件"
    echo " ** 用法: bash <path-to-script> <path-to-dependencies-file> [<path-to-local-manifest>]"
    exit 1
fi

if [ -n "$2" ]; then
    manifest_path="$2"
elif [ -e .repo ]; then
    mkdir -p .repo/local_manifests
    manifest_path=".repo/local_manifests/roomservice.xml"
else
    echo " ** 未指定 manifest 文件路径"
    echo " ** 且当前目录 $PWD 下不存在 .repo 文件夹"
    echo " ** 请从源码根目录运行此脚本或指定自定义路径"
    echo " ** 用法: bash <path-to-script> <path-to-dependencies-file> [<path-to-local-manifest>]"
    exit 1
fi

if [ -e "$manifest_path" ]; then
    sed -i 's@</manifest>@@g' "$manifest_path"
else
    echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > "$manifest_path"
    echo "<manifest>" >> "$manifest_path"
fi

vars=( "remote" "repository" "target_path" "branch" "revision" )
for i in ${!vars[@]}; do
    value=$(grep "${vars[$i]}" "$file" | cut -d '"' -f4)
    if [ "$value" != "" ]; then
        declare -a ${vars[$i]}"_val"="( $value )"
    fi
done

for i in {0..5}; do
    if [ "${repository_val[$i]}" != "" ] && [ "${target_path_val[$i]}" != "" ]; then
        target_path="path=\"${target_path_val[$i]}\""
        repository=" name=\"${repository_val[$i]}\""
        if [ "${remote_val[$i]}" != "" ]; then
            remote_for_repo=" remote=\"${remote_val[$i]}\""
        fi
        if [ "${branch_val[$i]}" != "" ]; then
            revision=" revision=\"${branch_val[$i]}\""
        elif [ "${revision_val[$i]}" != "" ]; then
            revision=" revision=\"${revision_val[$i]}\""
        fi
        echo "  <project $target_path$repository$remote_for_repo$revision />" >> "$manifest_path"
    fi
done

echo "</manifest>" >> "$manifest_path"
