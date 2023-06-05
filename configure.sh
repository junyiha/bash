#! /bin/bash 

function Recompile()
{
    echo "----In build----"
    cd build
    echo "----compile project---"
    cmake .. 
    make -j4
    echo "----Out build folder----"
    cd ..
}

function Compile()
{
    if [[ -d "build" ]]; then 
        echo "----delete build folder----"
        rm -r build
    fi 
    echo "----create build folder----"
    mkdir build
    Recompile
}

function Help()
{
    echo "configure.sh , a tool for common project"
    echo -e 
    echo "-re, --recompile  recompile test project"
    echo "-c, --compile compile test project"
    echo "-h, --help  print information of using"
    echo "-r, --run  run execute file, e.g: -r build/bin/fbd --old-fbd"
}

function Run()
{
    $1 $2 $3 $4
}

function Main()
{
    if [[ $1 == "-c" || $1 == "--compile" ]]; then 
        Compile
    elif [[ $1 == "-re" || $1 == "--recompile" ]]; then 
        Recompile
    elif [[ $1 == "-h" || $1 == "--help" ]]; then 
        Help
    elif [[ $1 == "-r" || $1 == "--run" ]]; then 
        Run $2 $3 $4 $5 $6 $7
    else 
        echo "----error argument, using '-h' for more information----"
    fi
}

Main $*