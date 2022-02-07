#!/bin/bash

# === CONFIGURE HERE ===
start_date="2021-07-21"
end_date="2023-07-10"
total_days=400   # number of random days in the range
# ======================

messages=(
    "Fix typo in README"
    "Update dependencies"
    "Refactor user authentication logic"
    "Improve error handling in API"
    "Optimize database queries"
    "Add unit tests for payment service"
    "Update UI for better mobile support"
    "Fix bug in checkout flow"
    "Improve logging for debugging"
    "Add missing translations"
    "Enhance form validation"
    "Update documentation"
    "Implement search functionality"
    "Fix CSS layout issue"
    "Improve image loading performance"
)

# Generate all days in range
all_days=()
current_sec=$(date -d "$start_date" +%s)
end_sec=$(date -d "$end_date" +%s)
while [ $current_sec -le $end_sec ]
do
    all_days+=($(date -d "@$current_sec" +%Y-%m-%d))
    current_sec=$((current_sec + 86400))
done

# Randomly pick N days from the list
selected_days=($(printf "%s\n" "${all_days[@]}" | shuf -n $total_days))

# Loop through chosen days
for day in "${selected_days[@]}"
do
    commits=$((RANDOM % 4))  # 5–10 commits

    for j in $(seq 1 $commits)
    do
        msg=${messages[$RANDOM % ${#messages[@]}]}

        echo "$msg" > file.js
        git add .

        # Random time 08:00–18:59
        hour=$((RANDOM % 11 + 8))
        minute=$((RANDOM % 60))
        second=$((RANDOM % 60))

        GIT_COMMITTER_DATE="$day $hour:$minute:$second" \
        git commit --date="$day $hour:$minute:$second" \
        -m "$msg"
    done
done