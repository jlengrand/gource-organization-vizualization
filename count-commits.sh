#!/bin/sh

# You need to have jq installed

echo "COUNTING COMMITS"

sum=0
for OUTPUT in $(ls -d */ | grep adyen)
do
    cd $OUTPUT;
	number=$(git rev-list --count HEAD --after=2021-01-01)
    sum=$((sum + number))
    cd ..;
done
echo "The total number of commits across repositories is: $sum"

echo "COUNTING PRs"

prs=$(curl -s "https://api.github.com/search/issues?q=org:adyen%20type:pr%20is:merged%20merged:%3E=2021-01-01" | jq '.total_count')

echo "The total number of merged PRs across repositories is: $prs"

echo "COUNTING Issues"

issues=$(curl -s "https://api.github.com/search/issues?q=org:adyen%20type:issue%20closed:%3E2021-01-01" | jq '.total_count')

echo "The total number of closed Issues across repositories is: $issues"

echo "COUNTING Contributors"

contributors=$(python3 unique-commiters.py)
echo "The total number of contributors across repositories is: $contributors"
