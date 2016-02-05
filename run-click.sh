#!/usr/bin/env sh
mode=$1
if [[ ! -z $mode ]]; then
    mode=" -m $mode"
fi

# 进入程序
#./cliclick $mode c:1419,584 # w:1000 c:345,862.5
if [[ $mode != "test" ]]; then
    echo "进入程序"
    osascript ./bringAppToFront.scpt || exit 1
    sleep 1
fi

function random_value(){
    min=$1
    max=$2
    echo $(( RANDOM % (`expr $max - $min`) + $min ))
}

function random_move(){
    x=$(random_value -50 50)
    y=$(random_value -50 50)
    echo "rc:+$x,+$y "
}

function confirm_skill(){
    x=$(random_value -50 50)
    y=$(random_value -50 50)
    echo "c:+$x,+$y "
}


App="Heroes"

function check_and_run(){
    top=`osascript ./check_terminal_is_front.scpt $App`
    echo "$App is front :" $top
    if [[ $top == "false" ]]; then
        exit 0
    else
        ./cliclick $@
    fi
}

while [[ true ]]; do
    #statements
    check_and_run $mode c:120,34.5 # 游戏
    sleep 0.5
    check_and_run $mode c:131,79.5 # 训练模式
    sleep 0.5
    check_and_run $mode c:696,854  # 准备

    # 等候过场动画
    sleep 1

    # 模拟移动
    check_and_run $mode -w 400 $(random_move)  $(random_move)  $(random_move)
    sleep 1

   #./cliclick $mode -w 200 c:497,870
   # 释放第一技能
   check_and_run $mode -w 200 kp:q $(confirm_skill) rc:+1,+1
   sleep 1
   # 释放第二技能
   check_and_run $mode -w 200 kp:w $(confirm_skill) rc:+1,+1
   sleep 1
   # 释放第三技能
   check_and_run $mode -w 200 kp:e $(confirm_skill) rc:+1,+1
   sleep 1

   # 释放第四技能
   check_and_run $mode -w 200 kp:r $(confirm_skill) rc:+1,+1
   sleep 1

   # 退出按钮
   check_and_run $mode -w 200 c:100,852
   sleep 1

   # 点击天赋
   check_and_run $mode -w 200 c:100,620 kd:ctrl ku:ctrl

   sleep $(random_value 2 15)
   done




 # 获取随机数 echo $(( RANDOM % (10000 ) + 5000 ))