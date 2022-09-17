#! /bin/bash +x

example_file="/data/dagger/manager_node.back/warning_record/config/gh_settings.ini"

warning_record="/data/dagger/manager_node/warning_record/config/gh_settings.ini"
web_backend="/data/dagger/manager_node/web_backend/config/gh_settings.ini"
websocket="/data/dagger/manager_node/websocket/config/gh_settings.ini"

if [ -f "$warning_record" ];then    
    rm $warning_record
    cp $example_file "/data/dagger/manager_node/warning_record/config/"
    tail -n 20 $warning_record
    echo ------------------------------------------------------------------------
else
    cp $example_file "/data/dagger/manager_node/warning_record/config/"
    tail -n 20 $warning_record
    echo ------------------------------------------------------------------------
fi

if [ -f "$web_backend" ];then
    rm $web_backend
    cp $example_file "/data/dagger/manager_node/web_backend/config/"
    tail -n 20 $web_backend
    echo ------------------------------------------------------------------------
else
    cp $example_file "/data/dagger/manager_node/web_backend/config/"
    tail -n 20 $web_backend
    echo ------------------------------------------------------------------------
fi

if [ -f "$websocket" ];then
    rm $websocket
    cp $example_file "/data/dagger/manager_node/websocket/config/"
    tail -n 20 $websocket
    echo ------------------------------------------------------------------------
else
    cp $example_file "/data/dagger/manager_node/websocket/config/"
    tail -n 20 $websocket
    echo ------------------------------------------------------------------------
fi
