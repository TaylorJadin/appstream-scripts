##make GIFT formatted test banks. Only true/false or multiple choice, for now
#!/bin/bash

if [ -z "$1" ]; then
	echo "Please give me a file to run through."
	exit
else
	echo "Thanks for the file.  Let's try to get through it."
fi

fname=$(echo $1 | sed 's/\// /g' | sed 's/.txt//' | sed 's/.csv//' | awk '{print $NF}')
bankLoc="/Users/Shared/$fname-testbank.txt"
touch $bankLoc

function multi {
    correctAns=$(cat "$1" | grep -A6 "$quesText" | grep "Answer" | sed 's/Answer:  //')
    ansText=$(cat "$1" | grep -A6 "$quesText" | grep "$correctAns)" )
    aRight=$(cat "$1" | grep -A6 "$quesText" | grep "A)" | sed 's/Answer: //')
    bRight=$(cat "$1" | grep -A6 "$quesText" | grep "B)" | sed 's/Answer: //')
    cRight=$(cat "$1" | grep -A6 "$quesText" | grep "C)" | sed 's/Answer: //')
    dRight=$(cat "$1" | grep -A6 "$quesText" | grep "D)" | sed 's/Answer: //')
    eRight=$(cat "$1" | grep -A6 "$quesText" | grep "E)" | sed 's/Answer: //')
    sedaRight=$(cat "$1" | grep -A6 "$quesText" | grep "A)" | sed 's/Answer: //' | sed 's/A) //')
    sedbRight=$(cat "$1" | grep -A6 "$quesText" | grep "B)" | sed 's/Answer: //' | sed 's/B) //')
    sedcRight=$(cat "$1" | grep -A6 "$quesText" | grep "C)" | sed 's/Answer: //' | sed 's/C) //')
    seddRight=$(cat "$1" | grep -A6 "$quesText" | grep "D)" | sed 's/Answer: //' | sed 's/D) //')
    sedeRight=$(cat "$1" | grep -A6 "$quesText" | grep "E)" | sed 's/Answer: //' | sed 's/E) //')

	if [ "$aRight" == "$ansText" ]; then
		echo "::$num:: $quesText { =$sedaRight ~$sedbRight ~$sedcRight ~$seddRight ~$sedeRight }" >> "$bankLoc"
	elif [ "$bRight" == "$ansText" ]; then
		echo "::$num:: $quesText { ~$sedaRight =$sedbRight ~$sedcRight ~$seddRight ~$sedeRight }" >> "$bankLoc"
	elif [ "$cRight" == "$ansText" ]; then
		echo "::$num:: $quesText { ~$sedaRight ~$sedbRight =$sedcRight ~$seddRight ~$sedeRight }" >> "$bankLoc"
	elif [ "$dRight" == "$ansText" ]; then
		echo "::$num:: $quesText { ~$sedaRight ~$sedbRight ~$sedcRight =$seddRight ~$sedeRight }" >> "$bankLoc"
	elif [ "$eRight" == "$ansText" ]; then
		echo "::$num:: $quesText { ~$sedaRight ~$sedbRight ~$sedcRight ~$seddRight =$sedeRight }" >> "$bankLoc"
	else
		echo '\\\ Not sure what to do with this question'
	fi
	echo "" >> "$bankLoc"
}

function truefalse {
	correctAns=$(cat "$1" | grep -A2 "$quesText" | grep "Answer" | sed 's/Answer:  //')
	if [ "$correctAns" == "TRUE" ]; then
		echo "::$num:: $quesText {T}" >> "$bankLoc"
	else
		echo "::$num:: $quesText {F}" >> "$bankLoc"
	fi
	echo "" >> "$bankLoc"
}

num=1
while [ $num -le 200 ]
do
	quesNum=$(cat "$1" | grep -A6 "$num)" | grep "Answer" | sed "s/Answer:  //" | head -1)
	quesText=$(cat "$1" | grep "$num)" | head -1 | sed "s/$num) //")
	if [[ "$quesNum" == "TRUE" ]]; then
		echo "This is a truefalse question"
		truefalse $1
	elif [[ "$quesNum" == "FALSE" ]]; then
		echo "This is a truefalse question"
		truefalse $1
	elif [[ "$quesNum" == "A" ]]; then
		echo "This is a multiple choice question"
		multi $1
	elif [[ "$quesNum" == "B" ]]; then
		echo "This is a multiple choice question"
		multi $1
	elif [[ "$quesNum" == "C" ]]; then
		echo "This is a multiple choice question"
		multi $1
	elif [[ "$quesNum" == "D" ]]; then
		echo "This is a multiple choice question"
		multi $1
	elif [[ "$quesNum" == "E" ]]; then
		echo "This is a multiple choice question"
		multi $1
	else 
		echo "$quesNum"
	fi
	num=$(($num + 1))
done


