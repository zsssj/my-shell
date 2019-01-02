#!/bin/bash
# horserace.sh: 非常简单的赛马模拟.
# 作者: Stefano Palmeri
# 已取得使用许可.

################################################################
# 脚本目的:
# 使用转义字符和终端颜色.
#
# 练习:
# 编辑脚本使其更具有随机性,
#+ 设置一个假的赌场 . . .
# 嗯 ... 嗯 ... 这个开始使我想起了一部电影 ...  
#
# 脚本给每匹马一个随机的障碍.
# 不均等会以障碍来计算
#+ 并且用一种欧洲风格表达出来.
# 例如: 机率(odds)=3.75 意味着如果你押 1 美元赢, 
#+ 你可以赢得 3.75 美元.
#
# 脚本已经在 GNU/Linux 操作系统上测试过 OS,
#+ 测试终端有 xterm 和 rxvt, 及 konsole.
# 测试机器有 AMD 900 MHz 的处理器,
#+ 平均比赛时间是 75 秒.
# 在更快的计算机上比赛时间应该会更低.
# 所以, 如果你想有更多的悬念,重设 USLEEP_ARG 变量的值.
#
# 由 Stefano Palmeri 编写.
################################################################

E_RUNERR=65 

# 检查 md5 和 bc 是不是安装了. 
if ! which bc &> /dev/null; then
    echo bc is not installed. 
    echo "Can\'t run . . . " 
    exit $E_RUNERR
fi
if ! which md5 &> /dev/null; then 
    echo md5 is not installed. 
    echo "Can\'trun..."
    exit $E_RUNERR
fi 

# 更改下面的变量值可以使脚本执行的更慢. 
# 它会作为 usleep 的参数 (man usleep)
#+ 并且它的单位是微秒 (500000 微秒 = 半秒).
USLEEP_ARG=0

# 如果脚本接收到 ctrl-c 中断,清除临时目录, 恢复终端光标和颜色
#
trap 'echo -en "\033[?25h"; echo -en "\033[0m"; stty echo;\
tput cup 20 0; rm -fr $HORSE_RACE_TMP_DIR' TERM EXIT
# 参考调试的章节了解'trap'的更多解释

# 给脚本设置一个唯一(实际不是绝对唯一的)的临时目录名.
HORSE_RACE_TMP_DIR=$HOME/.horserace-`date +%s`-`head -c10 /dev/urandom |md5 | head -c30` 

# 创建临时目录,并切换到该目录下.
mkdir $HORSE_RACE_TMP_DIR
cd $HORSE_RACE_TMP_DIR


# 这个函数把光标移动到行为 $1 列为 $2 然后打印 $3.
# 例如: "move_and_echo 5 10 linux" 等同于
#+ "tput cup 4 9; echo linux", 但是用一个命令代替了两个.
# 注: "tput cup" 表示在终端左上角的 0 0 位置,
#+ echo 是在终端的左上角的 1 1 位置.
move_and_echo() {
    echo -ne "\033[${1};${2}H""$3"
}

# 产生 1-9 之间伪随机数的函数.
random_1_9 () {
    head -c10 /dev/urandom | md5 | tr -d [a-z] | tr -d 0 | cut -c1
}

# 画马时模拟运动的两个函数.
draw_horse_one() {
    echo -n " "//$MOVE_HORSE//
}
draw_horse_two(){
    echo -n " "\\\\$MOVE_HORSE\\\\
}


# 取得当前的终端尺寸.
N_COLS=`tput cols`
N_LINES=`tput lines`

# 至少需要 20-行 X 80-列 的终端尺寸. 检查一下.
if [ $N_COLS -lt 80 ] || [ $N_LINES -lt 20 ]; then
    echo "`basename $0` needs a 80-cols X 20-lines terminal."
    echo "Your terminal is ${N_COLS}-cols X ${N_LINES}-lines."
    exit $E_RUNERR
fi


# 开始画赛场.

# 需要一个 80 个字符的字符串,看下面的.
BLANK80=`seq -s "" 100 | head -c80`

clear

# 把前景和背景颜色设置成白色的.
echo -ne '\033[37;47m'

# 把光标移到终端的左上角.
tput cup 0 0

# 画六条白线.
for n in `seq 5`; do
    echo $BLANK80       # 线是用 80 个字符组成的字符串.
done

# 把前景色设置成黑色.
echo -ne '\033[30m'

move_and_echo 3 1 "START 1"
move_and_echo 3 75 FINISH
move_and_echo 1 5 "|"
move_and_echo 1 80 "|"
move_and_echo 2 5 "|"
move_and_echo 2 80 "|"
move_and_echo 4 5 "| 2"
move_and_echo 4 80 "|"
move_and_echo 5 5 "V 3"
move_and_echo 5 80 "V"

# 把前景色设置成红色.
echo -ne '\033[31m'

# 一些 ASCII 艺术.
move_and_echo 1 8 "..@@@..@@@@@...@@@@@.@...@..@@@@..."
move_and_echo 2 8 ".@...@...@.......@...@...@.@......."
move_and_echo 3 8 ".@@@@@...@.......@...@@@@@.@@@@...."
move_and_echo 4 8 ".@...@...@.......@...@...@.@......."
move_and_echo 5 8 ".@...@...@.......@...@...@..@@@@..."
move_and_echo 1 43 "@@@@...@@@...@@@@..@@@@..@@@@."
move_and_echo 2 43 "@...@.@...@.@.....@.....@....."
move_and_echo 3 43 "@@@@..@@@@@.@.....@@@@...@@@.."
move_and_echo 4 43 "@..@..@...@.@.....@.........@."
move_and_echo 5 43 "@...@.@...@..@@@@..@@@@.@@@@.."


# 把前景和背景颜色设为绿色.
echo -ne '\033[32;42m'

# 画 11 行绿线.
tput cup 5 0
for n in `seq 11`; do
    echo $BLANK80
done

# 把前景色设为黑色.
echo -ne '\033[30m'
tput cup 5 0 

# 画栅栏.
echo "++++++++++++++++++++++++++++++++++++++\
++++++++++++++++++++++++++++++++++++++++++"

tput cup 15 0
echo "++++++++++++++++++++++++++++++++++++++\
++++++++++++++++++++++++++++++++++++++++++"

# 把前景和背景色设回白色.
echo -ne '\033[37;47m'

# 画3条白线.
for n in `seq 3`; do
    echo $BLANK80
done

# 把前景色设为黑色.
echo -ne '\033[30m'

# 创建 9 个文件来保存障碍物.
for n in `seq 10 7 68`; do
    touch $n
done

# 设置脚本要画的马的类型为第一种类型.
HORSE_TYPE=2

# 为每匹马创建位置文件和机率文件.
#+ 在这些文件里保存了该匹马当前的位置,
#+ 类型和机率.
for HN in `seq 9`; do
    touch horse_${HN}_position
    touch odds_${HN}
    echo \-1 > horse_${HN}_position
    echo $HORSE_TYPE >> horse_${HN}_position 
    # 给马定义随机的障碍物.
    HANDICAP=`random_1_9`
    # 检查 random_1_9 函数是否返回了有效值.
    while ! echo $HANDICAP | grep [1-9] &> /dev/null; do
        HANDICAP=`random_1_9` 
    done
    # 给马定义最后的障碍的位置.
    LHP=`expr $HANDICAP \* 7 + 3`
    for FILE in `seq 10 7 $LHP`; do
        echo $HN >> $FILE
    done

    # 计算机率.
    case $HANDICAP in
        1) ODDS=`echo $HANDICAP \* 0.25 + 1.25 | bc`
                echo $ODDS > odds_${HN}
        ;;
        2|3) ODDS=`echo $HANDICAP \* 0.40 + 1.25 | bc` 
                echo $ODDS > odds_${HN}
        ;;
        4|5|6) ODDS=`echo $HANDICAP \* 0.55 + 1.25 | bc`
                echo $ODDS > odds_${HN}
        ;;
        7|8) ODDS=`echo $HANDICAP \* 0.75 + 1.25 | bc` 
                echo $ODDS > odds_${HN}
        ;;
        9) ODDS=`echo $HANDICAP \* 0.90 + 1.25 | bc`
                echo $ODDS > odds_${HN}
    esac


done

# 打印机率.
print_odds() {
tput cup 6 0
echo -ne '\033[30;42m'
for HN in `seq 9`; do
    echo "#$HN odds->" `cat odds_${HN}`
done
}

# 在起跑线上画马.
draw_horses() {
tput cup 6 0
echo -ne '\033[30;42m'
for HN in `seq 9`; do
    echo /\\$HN/\\ "                            "
done
}

print_odds

echo -ne '\033[47m'
# 等待回车按键开始赛马.
# 转义序列'\033[?25l'禁显了光标.
tput cup 17 0
echo -e '\033[?25l'Press [enter] key to start the race...
read -s

# 禁用了终端的常规显示功能.
# 这避免了赛跑时不小心按了按键键入显示字符而弄乱了屏幕.
#
stty -echo

# --------------------------------------------------------
# 开始赛跑.

draw_horses
echo -ne '\033[37;47m'
move_and_echo 18 1 $BLANK80
echo -ne '\033[30m'
move_and_echo 18 1 Starting...
sleep 1

# 设置终点线的列数.
WINNING_POS=74

# 记录赛跑开始的时间.
START_TIME=`date +%s`

# COL 是由下面的"while"结构使用的.
COL=0

while [ $COL -lt $WINNING_POS ]; do 

    MOVE_HORSE=0

    # 检查 random_1_9 函数是否返回了有效值.
    while ! echo $MOVE_HORSE | grep [1-9] &> /dev/null; do
        MOVE_HORSE=`random_1_9`
    done

    # 取得随机取得的马的类型和当前位置.
    HORSE_TYPE=`cat horse_${MOVE_HORSE}_position | tail -1`
    COL=$(expr `cat horse_${MOVE_HORSE}_position | head -1`)

    ADD_POS=1
    # 检查当前的位置是否是障碍物的位置.
    if seq 10 7 68 | grep -w $COL &> /dev/null; then
        if grep -w $MOVE_HORSE $COL &> /dev/null; then
            ADD_POS=0
            grep -v -w $MOVE_HORSE $COL > ${COL}_new
            rm -f $COL
            mv -f ${COL}_new $COL
        else ADD_POS=1
        fi
    else ADD_POS=1
    fi
    COL=`expr $COL + $ADD_POS`
    echo $COL > horse_${MOVE_HORSE}_position # 保存新位置.

    # 选择要画的马的类型.
    case $HORSE_TYPE in
        1) HORSE_TYPE=2; DRAW_HORSE=draw_horse_two
        ;;
        2) HORSE_TYPE=1; DRAW_HORSE=draw_horse_one
    esac
    echo $HORSE_TYPE >> horse_${MOVE_HORSE}_position # 保存当前类型.

    # 把前景色设为黑,背景色设为绿.
    echo -ne '\033[30;42m'

    # 把光标位置移到新的马的位置.
    tput cup `expr $MOVE_HORSE + 5``cat horse_${MOVE_HORSE}_position |head -1`

    # 画马.
    $DRAW_HORSE
#    usleep $USLEEP_ARG         # mac 没有
    sleep 1

    # 当所有的马都越过 15 行的之后,再次打印机率.
    touch fieldline15
    if [ $COL = 15 ]; then
        echo $MOVE_HORSE >> fieldline15
    fi
    if [[ `wc -l fieldline15 | cut -f1 -d " "` = 9 ]]; then
        print_odds
        : > fieldline15
    fi

    # 取得领头的马.
    HIGHEST_POS=`cat *position | sort -n | tail -1`

    # 把背景色重设为白色.
    echo -ne '\033[47m'
    tput cup 17 0
    echo -n Current leader: `grep -w $HIGHEST_POS *position | cut -c7`""

done 

# 取得赛马结束的时间.
FINISH_TIME=`date +%s`

# 背景色设为绿色并且启用闪动的功能.
echo -ne '\033[30;42m'
echo -en '\033[5m'

# 使获胜的马闪动.
tput cup `expr $MOVE_HORSE + 5` `cat horse_${MOVE_HORSE}_position | head -1`
$DRAW_HORSE

# 禁用闪动文本.
echo -en '\033[25m'

# 把前景和背景色设为白色.
echo -ne '\033[37;47m'
move_and_echo 18 1 $BLANK80

# 前景色设为黑色.
echo -ne '\033[30m'

# 闪动获胜的马.
tput cup 17 0
echo -e "\033[5mWINNER: $MOVE_HORSE\033[25m"" Odds: `cat odds_${MOVE_HORSE}`"\
"  Race time: `expr $FINISH_TIME - $START_TIME` secs"

# 恢复光标和最初的颜色.
echo -en "\033[?25h"
echo -en "\033[0m"

# 恢复回显功能.
stty echo

# 删除赛跑的临时文件.
rm -rf $HORSE_RACE_TMP_DIR

tput cup 19 0

exit 0 
################################End Script#########################################
