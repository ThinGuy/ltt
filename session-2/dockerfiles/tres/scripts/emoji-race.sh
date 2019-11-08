
emoji-race() {
local DESC="${RO}${FUNCNAME}\e[0m: Race emjois across your terminal\n"
emoji-race_usage() {
    printf "\n${DESC}\n"
    printf "\e[1mUsage\e[0m: ${FUNCNAME%%_*} -c <# of racers> ( -n <list of names> )\n\n"
    printf "\n\e[1mOptions\e[0m:\n\n"
    printf "\e[2G -c, --count \e[20GNumber of racers\n"
    printf "\e[2G -n, --names \e[20GOptional: Comma separated list of racer names\n"
    printf "\e[2G -h, --help\e[20GThis message\n\n"
 }
unset COUNT NAMES
[[ -f ~/.winner ]] && rm ~/.winner;
ARGS=$(getopt -o c:n:h --long count:,names:,help -n ${FUNCNAME} -- "$@")
eval set -- "$ARGS"
while true ; do
	case "$1" in
	    -c|--count) export COUNT=${2};shift 2;;
	    -n|--names) export NAMES=${2};shift 2;;
	    -h|--help) ${FUNCNAME}_usage;return;;
	    --) shift;break;;
	esac
done
[[ -n ${COUNT} && ! ${COUNT} =~ ^[0-9]+ ]] && { printf "Invalid count: ${COUNT}\n";return 1; }
[[ -n ${NAMES} ]] && declare -ag NAMES=($(printf "%s\n" ${NAMES//,/ }|sed -E '/^$|^ | ^/d'))
[[ -z ${COUNT} && ${#NAMES[@]} -gt 0 ]] && local COUNT=${#NAMES[@]}
[[ -z ${COUNT} ]] && COUNT=3
[[ -n ${NAMES[@]} && ${#NAMES[@]} -lt ${COUNT} ]] && { printf "Number of names (${#NAMES[@]}) should match racer counts (${COUNT})\n";return 1; }
[[ ${COUNT} -gt $(tput lines) ]] && { printf "Racer count (${COUNT}) must be less than terminal lines ($(tput lines))\n";return 1; }
tput -S <<EOF
smcup
rmam
civis
EOF
clear
local -a pidlist
declare -ag ERACERS=(
🚌 🚐 🚑 🚒 🚓 🚕 🚗 🚙 🚚 🚛 🚜 🚲 🛴 🛵 🚂 🐵 🐒 🦍 🐶 🐕 🐩 🐺 🦊 🐱 🐈 🦁 🐯 🐅 🐆 🐴 🐎 🦄 🦓 🦌 🐮 🐂 🐃 🐄 🐷 🐖 🐗 🐏 🐑 🐐 🐪 🐫 🦒 🐘 🦏 🐭 🐁 🐀 🐹 🐰 🐇 🐿 🦔 🦇 🐻 🐨 🐼 🦃 🐔 🐓 🐣 🐤 🐥 🐦 🐧 🦅 🦆 🦉 🐸 🐊 🐢 🦎 🐍 🐲 🐉 🦕 🦖 🐳 🐋 🐬 🐟 🐠 🐡 🦈 🐙 🐚 🦀 🦐 🦑 🐌 🦋 🐛 🐜 😀 😁 😂 🤣 😃 😄 😅 😆 😉 😊 😋 😎 😍 😘 😗 😙 😚 ☺️ 🙂 🤗 🤩 🤔 🤨 😐 😑 😶 🙄 😏 😣 😥 😮 🤐 😯 😪 😫 😴 😌 😛 😜 😝 🤤 😒 😓 😔 😕 🙃 🤑 😲 ☹️ 🙁 😖 😞 😟 😤 😢 😭 😦 😧 😨 😩 🤯 😬 😰 😱 😳 🤪 😵 😡 😠 🤬 😷 🤒 🤕 🤢 🤮 🤧 😇 🤠 🤥 🤫 🤭 🧐 🤓 🤡 👹 👺 💀 ☠️ 👻 👽 👾 🤖 💩
)
declare -ag RACERS=($(for i in $(seq 1 1 ${COUNT});do echo ${ERACERS[$RANDOM%$((${#ERACERS[@]}-1))]};done))
trap 'tput sgr0;tput smam;tput rmcup;tput cnorm;trap - INT TERM EXIT;kill -9 ${pidlist[*]};return 0' INT TERM EXIT
declare -ag ST=($( printf "%02d\n" ${!RACERS[@]}|xargs -n1 sh -c 'printf "%02d\n" $(($0+2))'))
for r in ${!RACERS[@]};do
	(for i in $(seq $(($(tput cols)-2)) -1 2);do 
		[[ ! -f ~/.winner ]] && { printf -- "\e[$((${r}+1));$((${i}-1))H${RACERS[r]} ${NAMES[r]}\e[K" && echo "$((${i}-1)) ${NAMES[r]}" > racer.${r}; 
		sleep .${ST[$RANDOM%${#ST[@]}]}; }
	done;[[ ! -f ~/.winner ]] && { echo ${r} > ~/.winner && printf "\e[$((${r}+1));$((${i}-1))H${RACERS[$r]}  Winner";[[ ${#NAMES[@]} -eq ${#RACERS[@]} ]] && printf " = ${NAMES[r]}";sleep 6; } ) & 2>/dev/null
	pidlist+=( "$!" )
done
wait ${pidlist[*]}
trap - INT TERM EXIT
tput -S <<EOF
sgr0
rmcup
smam
cnorm
EOF
} 2>/dev/null

beep-beep() { 
trap 'tput smam;tput cnorm;trap - INT TERM EXIT;return' INT TERM EXIT
local MSG="${@}"
declare -ag TARR=($(grep -oE '.| ' <<< "${MSG// /_}"))
declare -ag VARR=(🏎️ 🚌 🚐 🚑 🚒 🚓 🚕 🚗 🚙 🚚 🚛 🚜 🚎 🏎️ 🚌 🚐 🚑 🚒 🚓 🚕 🚗 🚙 🚚 🚛 🚜 🚎)
tput rmam;tput civis
LINE=
STOP=1
for t in ${!TARR[@]};do 
	for i in $(seq $((${#TARR[@]}+30)) -1 $STOP);do
		printf "\e[$((${i}-1))G${TARR[t]//_/ } ${VARR[t]}\e[K\r${LINE}"; sleep .03;
	done
	LINE="${LINE}${TARR[t]//_/ }"
	STOP=$((${#LINE}+2))
	tput el
done
trap - INT TERM EXIT
printf "\r\e[K\r${MSG}\n"
tput smam;tput cnorm
}
