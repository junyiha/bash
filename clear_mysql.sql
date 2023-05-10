function OldMethod()
{
    use ManagerV3;

    delete from gh_t_camera_info;

    delete from gh_t_face_db;

    delete from gh_t_face_image;

    delete from gh_t_face_info;

    delete from gh_t_func_conf;

    delete from gh_t_journal;

    delete from gh_t_record_json;

    delete from gh_t_task;

    delete from gh_t_warning_event;

    delete from gh_t_warning_record;

    delete from gh_t_gpu;

    delete from gh_t_server;

}

function NewMethod()
{
    sql="mysql -uroot -p123456"
    $sql -e "use ManagerV3;" -e "show tables;"
    $sql -e "use ManagerV3;" -e "delete from gh_t_camera_info;"

    $sql -e "use ManagerV3;" -e "delete from gh_t_face_db;"

    $sql -e "use ManagerV3;" -e "delete from gh_t_face_image;"

    $sql -e "use ManagerV3;" -e "delete from gh_t_face_info;"

    $sql -e "use ManagerV3;" -e "delete from gh_t_func_conf;"

    $sql -e "use ManagerV3;" -e "delete from gh_t_journal;"

    $sql -e "use ManagerV3;" -e "delete from gh_t_record_json;"

    $sql -e "use ManagerV3;" -e "delete from gh_t_task;"

    $sql -e "use ManagerV3;" -e "delete from gh_t_warning_event;"

    $sql -e "use ManagerV3;" -e "delete from gh_t_warning_record;"

    $sql -e "use ManagerV3;" -e "delete from gh_t_gpu;"

    $sql -e "use ManagerV3;" -e "delete from gh_t_server;"
}

NewMethod