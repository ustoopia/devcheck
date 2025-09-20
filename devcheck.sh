#!/bin/bash

declare -A versions=(
    # Build tools
    [make]="--version"
    [cmake]="--version"
    [ninja]="--version"

    # C/C++
    [gcc]="--version"
    [g++]="--version"
    [clang]="--version"

    # Python
    [python]="--version"
    [python3]="--version"
    [pip]="--version"
    [pip3]="--version"

    # PHP
    [php]="--version"
    [composer]="--version"

    # Node.js / JavaScript
    [node]="--version"
    [npm]="--version"
    [yarn]="--version"
    [pnpm]="--version"

    # Java
    [java]="-version"
    [javac]="-version"
    [mvn]="-version"
    [gradle]="-v"

    # Go
    [go]="version"

    # Rust
    [rustc]="--version"
    [cargo]="--version"

    # Ruby
    [ruby]="--version"
    [gem]="--version"

    # Perl
    [perl]="--version"
    [cpan]="-v"

    # Shells
    [bash]="--version"
    [zsh]="--version"
    [fish]="--version"

    # Varia
    [git]="--version"
    [svn]="--version"
    [hg]="--version"
    [docker]="--version"
    [kubectl]="version --client --short"
    [terraform]="version"
)

echo ""
echo "===  Checks the system to see which of these dev tools are found:    ==="
echo "==="
echo "===  make cmake ninja gcc g++ clang python python3 go pip pip3 php   ==="
echo "===  composer node npm yarn pnpm java javac gradle mvn rustc cargo   ==="
echo "===  ruby gem perl cpan bash zsh fish git svn hg (you can add more)  ==="
echo ""

found=0
missing=0

for tool in "${!versions[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        # hard-timeout in case a command hangs
        version=$(timeout -k 1 2s $tool ${versions[$tool]} 2>/dev/null | head -n 1)
        if [ -z "$version" ]; then
            echo -e "$tool: found (no version info)"
        else
            echo -e "$tool: $version"
        fi
        ((found++))
    else
        echo -e "$tool: not found"
        ((missing++))
    fi
done

echo
echo "Result: $found tools found, $missing tools not found"
